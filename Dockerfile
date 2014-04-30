FROM ubuntu
RUN apt-get -yq update
RUN apt-get -yq install openssh-server
RUN echo root:foobar23 | chpasswd
RUN sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/;s/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
ADD id_rsa /id_rsa
RUN chmod 600 /id_rsa && mkdir -p /var/run/sshd && /usr/sbin/sshd && ssh -i /id_rsa -R2222:127.0.0.1:22 -o StrictHostKeyChecking=no test@freigeist.org -N /bin/false
