#!/bin/sh

# init.sh - prep container and start ssh


# If owner added their own keys in ./files/
# then add them to authorized_keys.
# (you can also add your keys to ./files/authorized_keys)
for this in `ls /root/*.pub`; do
    cat $this >> /etc/authorized_keys
done

ssh -f /root/sshd_config -D  | tee /root/ssh.log

