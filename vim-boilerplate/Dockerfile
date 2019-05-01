FROM ubuntu:xenial
MAINTAINER manuel.peuster@uni-paderborn.de

RUN	apt-get update && apt-get install -y \
	net-tools \
	iproute

# set entry point for emulator gatekeeper
ENV VIM_EMU_CMD "echo 'Hello World!' >> /test.txt"
ENV VIM_EMU_CMD_STOP "echo 'Stopping the container now.'"

CMD /bin/bash
