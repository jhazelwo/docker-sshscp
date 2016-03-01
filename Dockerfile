FROM centos:6
MAINTAINER "John Hazelwood" <jhazelwo@users.noreply.github.com>

RUN yum clean expire-cache && yum -y update && yum -y install yum-utils
RUN yum -y install rsync openssh-server openssh-clients passwd

RUN /usr/bin/install -o 1000 -g 0 -m 0600 /dev/null /etc/authorized_keys
RUN /usr/sbin/groupadd -g 1000 data
RUN /usr/sbin/useradd -u 1000 -g 1000 -d /home/data data
RUN /usr/bin/passwd -u -f data

ADD ./files/ /root/

CMD /root/init.sh

EXPOSE 22022

