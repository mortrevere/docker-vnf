FROM       ubuntu:16.04
MAINTAINER Léo

RUN	apt-get update && apt-get install -y \
	net-tools \
	iproute iputils-ping iperf tcpdump openssh-server netcat

RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdwLcy4I1WBVCqTrhku3uVQ/bbXoatNuOm0k4rlctABC4mSACLvuIMIdXKUXdNisOgJ9FDUvL+jK3Jks9gi1AeDL0mP3cCBWu951pkI3j13SW78rKG5qUHfXbmiV2KfxTaVmLDXQTh2cy0+AJ7iuQIvglm5vSRmLSTg81UzxlEElb+wRiIwBPgMqD0yWb7HuRngBkQLS0ioydxOE9NQ4k/chCcLee5d1MEtHN9K28P6UdGqJcxKnrGyCoOiJygdBfHaYhjHyMYpV1hWNKY8vxODrd4Ja8iKXV1tdya1bNAt6eEyeIFDpRU8VunT+XL7YNzTcQdurGGnAwf7CENlWYh mortrevere@leo-vaio" > /root/.ssh/authorized_keys

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

RUN echo 'ip a | grep ping' > /root/.bashrc

EXPOSE 22

# set entry point for emulator gatekeeper
ENV VIM_EMU_CMD "service ssh start"

CMD /bin/bash
