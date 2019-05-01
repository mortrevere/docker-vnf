FROM      ubuntu:trusty
MAINTAINER mortrevere

RUN	apt-get update && apt-get install -y \
	net-tools \
	iproute \
	inetutils-ping \
	tcpdump iptables

ADD start_fw.sh start.sh
RUN chmod +x start.sh
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump

# set entry point for emulator gatekeeper
ENV SON_EMU_CMD "./start.sh | tee /fw.log"

CMD /bin/bash
