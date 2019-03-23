#!/bin/bash

# Add the ssh config if needed

if [ ! -f "/etc/ssh/sshd_config" ];
	then
		cp /ssh_orig/sshd_config /etc/ssh
fi

if [ ! -f "/etc/ssh/ssh_config" ];
	then
		cp /ssh_orig/ssh_config /etc/ssh
fi

if [ ! -f "/etc/ssh/moduli" ];
	then
		cp /ssh_orig/moduli /etc/ssh
fi

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

# generate xrdp key
if [ -f "/usr/bin/xrdp-keygen" ];
	then
	if [ ! -f "/etc/xrdp/rsakeys.ini" ];
		then
			xrdp-keygen xrdp auto
	fi
fi

# generate machine-id
uuidgen > /etc/machine-id

# set keyboard for all sh users
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile
echo 'export LANG="ko_KR.UTF-8"' >> /etc/profile
echo 'export LANG="ko_KR.EUC-KR"' >> /etc/profile
echo 'export LANGUAGE="ko_KR;ko;en_GB;en"' >> /etc/profile
echo 'export LC_ALL="ko_KR.UTF-8"' >> /etc/profile

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

exec "$@"
