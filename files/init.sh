#!/bin/sh

# init.sh - prep container and start ssh

# If owner added their own keys in ./files/
# then add them to authorized_keys.
for this in `ls /root/*.pub`; do
    cat $this >> /etc/authorized_keys
    echo "" >> /etc/authorized_keys
done

# You can specify your own host keys by copying them
# via Dockerfile, else we'll create new ones.
test -f /etc/ssh/ssh_host_dsa_key || ssh-keygen -q -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
test -f /etc/ssh/ssh_host_rsa_key || ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa

echo "root:`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`" | chpasswd
echo "data:`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`" | chpasswd

/usr/sbin/sshd -f /root/sshd_config -D -e

