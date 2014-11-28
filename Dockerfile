FROM centos:centos6

RUN rpm -i http://mir01.syntis.net/epel/6/i386/epel-release-6-8.noarch.rpm && \
    yum install -y gitolite3 openssh-server

COPY run.sh run-gitolite.sh /

VOLUME /data

#ENV HOSTNAME
#ENV SSH_ADMIN_KEY

CMD /run.sh
