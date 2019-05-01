FROM       ubuntu:16.04
MAINTAINER Léo

RUN	apt-get update && apt-get install -y \
	net-tools \
	iproute iputils-ping iperf tcpdump wget

WORKDIR /root
RUN wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz                  
RUN wget https://www.snort.org/downloads/snort/snort-2.9.13.tar.gz
RUN apt-get install -y netcat build-essential checkinstall gcc flex bison libpcap-dev libpcre3-dev libdumbnet-dev zlib1g-dev iptables-dev libnetfilter-queue1 luajit libluajit-5.1-dev
RUN tar xvzf daq-2.0.6.tar.gz                  
RUN tar xvzf snort-2.9.13.tar.gz

WORKDIR /root/daq-2.0.6
RUN ./configure && make && make install
WORKDIR /root/snort-2.9.13
RUN ./configure --enable-sourcefire --disable-open-appid && make && make install

RUN ldconfig

RUN mkdir -p /etc/snort
RUN mkdir -p /etc/snort/rules
RUN echo 'alert icmp any any -> any any (msg:"Pinging...";sid:1000004;)' > /etc/snort/rules/local.rules
RUN cp -r ./etc /etc/snort
RUN mkdir -p /usr/local/lib/snort_dynamicrules
RUN sed -i 's/include \$RULE_PATH\/[0-9a-z-]*.rules//g' /etc/snort/etc/snort.conf
RUN touch /etc/snort/rules/black_list.rules
RUN touch /etc/snort/rules/white_list.rules
RUN echo 'include $RULE_PATH/local.rules' >> /etc/snort/etc/snort.conf
RUN mkdir -p /var/log/snort/
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sysctl -w net.ipv4.ip_forward=0

# set entry point for emulator gatekeeper
ENV VIM_EMU_CMD "snort -d -i eth0 -c /etc/snort/etc/snort.conf -A fast"

CMD /bin/bash
