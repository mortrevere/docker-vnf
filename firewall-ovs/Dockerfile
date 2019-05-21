FROM      ubuntu:trusty
MAINTAINER Leo

ENV HOME /root
WORKDIR /root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    python-setuptools \
    python-pip \
    python-eventlet \
    python-lxml \
    python-msgpack \
    iproute2 \
 && curl -kL https://github.com/osrg/ryu/archive/master.tar.gz | tar -xvz \
 && mv ryu-master ryu \
 && cd ryu \
 && pip install -r tools/pip-requires \
 && python setup.py install


RUN	apt-get install -y \
	net-tools \
	inetutils-ping \
        iproute \
	tcpdump iptables

# install OpenvSwitch 
RUN apt-get install -y openvswitch-switch openvswitch-common nano

RUN apt-get install -y git
RUN git clone --single-branch --branch osm-integration https://github.com/mortrevere/ovs-l7-filter.git

ADD start_fw.sh start.sh
RUN chmod +x start.sh
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump
RUN pip install --upgrade six

# set entry point for emulator gatekeeper
#ENV SON_EMU_CMD "./start.sh | tee /fw.log"
ENV SON_EMU_CMD "echo prout > /flag.start"

CMD /bin/bash
