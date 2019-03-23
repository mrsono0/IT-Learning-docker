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

# /usr/sbin/sshd -D -f /etc/ssh/sshd_config &
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &
exec "$@"
