#!/bin/bash

set -ex

HOSTNAME=$1
SSH_ADMIN_KEY=$2

echo "$SSH_ADMIN_KEY" >> /tmp/adminkey.pub
gitolite setup -pk /tmp/adminkey.pub

touch $HOME/.ssh/config
chmod 0600 $HOME/.ssh/config

ssh-keygen -P "" -f $HOME/.ssh/id_rsa >/dev/null 2>&1
cat $HOME/.ssh/id_rsa.pub

sed -i "s/# HOSTNAME.*/HOSTNAME => \"$HOSTNAME\",/" $HOME/.gitolite.rc
sed -i "s/#.* 'Mirroring'.*/'Mirroring',/" $HOME/.gitolite.rc
