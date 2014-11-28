#!/bin/bash

set -ex

if [ ! -d /data/gitolite3 ]; then

    service sshd start

    su -l gitolite3 -c "/run-gitolite.sh $HOSTNAME \"$SSH_ADMIN_KEY\""

    mv /var/lib/gitolite3 /data

    service sshd stop

    mkdir -p /data/ssh
    mv /etc/ssh/ssh_host_key /data/ssh
    mv /etc/ssh/ssh_host_rsa_key /data/ssh
    mv /etc/ssh/ssh_host_dsa_key /data/ssh
fi

ln -s /data/gitolite3 /var/lib/gitolite3
ln -s /data/ssh/ssh_host_key /etc/ssh/ssh_host_key
ln -s /data/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ln -s /data/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_dsa_key

exec /usr/sbin/sshd -D
