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

set -o pipefail

# Copy files from /usr/share/maven/ref into ${MAVEN_CONFIG}
# So the initial ~/.m2 is set with expected content.
# Don't override, as this is just a reference setup
copy_reference_file() {
  local root="${1}"
  local f="${2%/}"
  local logfile="${3}"
  local rel="${f/${root}/}" # path relative to /usr/share/maven/ref/
  echo "$f" >> "$logfile"
  echo " $f -> $rel" >> "$logfile"
  if [[ ! -e ${MAVEN_CONFIG}/${rel} || $f = *.override ]]
  then
    echo "copy $rel to ${MAVEN_CONFIG}" >> "$logfile"
    mkdir -p "${MAVEN_CONFIG}/$(dirname "${rel}")"
    cp -r "${f}" "${MAVEN_CONFIG}/${rel}";
  fi;
}

copy_reference_files() {
  local log="$MAVEN_CONFIG/copy_reference_file.log"

  if (sh -c "mkdir -p \"$MAVEN_CONFIG\" && touch \"${log}\"" > /dev/null 2>&1)
  then
      echo "--- Copying files at $(date)" >> "$log"
      find /usr/share/maven/ref/ -type f -exec bash -eu -c 'copy_reference_file /usr/share/maven/ref/ "$1" "$2"' _ {} "$log" \;
  else
    echo "Can not write to ${log}. Wrong volume permissions? Carrying on ..."
  fi
}

export -f copy_reference_file
copy_reference_files
unset MAVEN_CONFIG

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

exec "$@"
