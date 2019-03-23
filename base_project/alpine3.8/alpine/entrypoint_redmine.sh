#!/bin/sh
set -e

# generate fresh rsa key if needed
if [ ! -f "/etc/ssh/ssh_host_rsa_key" ];
	then 
		ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

# generate fresh dsa key if needed
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ];
	then 
		ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

# generate fresh dsa key if needed
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ];
	then 
		ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi

#prepare run dir
mkdir -p /var/run/sshd
sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
sed -i "s/#UsePAM no/UsePAM no/g" /etc/ssh/sshd_config && \
sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config && \
sed -i "s/#Port 22/Port 22/g" /etc/ssh/sshd_config 

#prepare xauth
touch /home/alpine/.Xauthority
chown alpine:alpine /home/alpine/.Xauthority

# generate machine-id
uuidgen > /etc/machine-id

# set keyboard for all sh users
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile

source /etc/profile

cd ${REDMINE_HOME}

case "$1" in
	rails|passenger)
		adapter=$(ruby -e "
require 'json'
require 'yaml'
unless File.exist?('Passengerfile.json') or ENV['REDMINE_PASSENGER'].nil?
	conf = JSON.parse(ENV['REDMINE_PASSENGER'])
	JSON.dump(conf,File.open('Passengerfile.json','w'))
end
unless File.exist?('config/secrets.yml') or ENV['REDMINE_SECRETS'].nil?
	conf = JSON.parse(ENV['REDMINE_SECRETS'])
	YAML.dump(conf,File.open('config/secrets.yml','w'))
end
unless File.exist?('config/configuration.yml') or ENV['REDMINE_CONFIGURATION'].nil?
	conf = YAML.load_file('config/configuration.yml.example')
	conf.merge!(JSON.parse(ENV['REDMINE_CONFIGURATION']))
	YAML.dump(conf,File.open('config/configuration.yml','w'))
end
if File.exist?('config/database.yml')
	conf = YAML.load_file('config/database.yml')
	puts conf[ENV['RAILS_ENV']]['adapter']
else
	conf = JSON.parse(ENV['REDMINE_DATABASE']||'{\"production\":{\"adapter\":\"sqlite3\",\"database\":\"db/redmien.sqlite3\"}}')
	YAML.dump(conf,File.open('config/database.yml','w'))
	puts conf[ENV['RAILS_ENV']]['adapter']
end
		")
		
		cp Gemfile.lock.${adapter} Gemfile.lock
		bundle check || bundle install --without development test
		rm -fr /root/.bundle /root/.gem $(gem env gemdir)/cache
		
		if [ ! -f config/secrets.yml \
		  -a ! -f config/initializers/secret_token.rb ]; then
			rake generate_secret_token
		fi
		rake db:migrate
		rake redmine:plugins:migrate
		
		if [ "$1" = 'passenger' ]; then
			set -- tini -- "$@"
		fi
		
		;;
esac
/usr/bin/supervisord -n &
exec "$@"