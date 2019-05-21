#! /bin/bash

sysctl -w net.ipv4.ip_forward=0
echo "FW container started"

#/root/ryu/bin/ryu-manager --verbose /root/simple_firewall.py ryu.app.ofctl_rest 2>&1 | tee /ryu.log &
ryu-manager /root/ovs-l7-filter/ovs-l7-filter.py 2>&1 | tee /ryu.log &

echo "Start ovs"
service openvswitch-switch start

# Configuration parameters of the switch can for example be configured by a docker environment variable
# but configuration is not yet implemented in the (dummy) gatekeeper, so we hard code it for now
# also controller ip address should be configured by a service controller after vnfs are deployed and assigned an ip address

NAME="ovs1"
OVS_DPID="0000000000000001"

# declare an array variable holding the ovs port names
# the interfaces are expected to be configured from the vnfd or nsd
declare -a PORTS=("fwin-0" "fwout-0")

echo "setup ovs bridge"
ovs-vsctl add-br $NAME
sleep 3
#ovs-vsctl set bridge $NAME datapath_type=netdev
ovs-vsctl set bridge $NAME protocols=OpenFlow10,OpenFlow12,OpenFlow13
ovs-vsctl set-fail-mode $NAME secure
#ovs-vsctl set bridge $NAME other_config:disable-in-band=true
ovs-vsctl set bridge $NAME other-config:datapath-id=$OVS_DPID
#ovs-vsctl set controller $NAME connection-mode=out-of-band
#ovs-vsctl set bridge $NAME stp_enable=true

## now loop through the PORTS array
COUNTER=1
for i in "${PORTS[@]}"
do
   echo "added port $i to switch $NAME at index $COUNTER"
   ovs-vsctl add-port $NAME $i -- set Interface $i ofport=$COUNTER
   (( COUNTER++ ))
   # or do whatever with individual element of the array
done

#ovs-vsctl set-controller $NAME $CONTROLLER

echo "setting up controller"
sleep 5
CONTROLLER_IP="127.0.0.1"
CONTROLLER="tcp:$CONTROLLER_IP:6633"
ovs-vsctl set-controller $NAME $CONTROLLER

ovs-vsctl -- --columns=name,ofport list Interface

echo "done !"

#ovs-ofctl add-flow $NAME 'ip,tcp,tcp_dst=80,in_port=1,action=drop' -O OpenFlow13
#sleep 1
#ovs-ofctl add-flow $NAME 'priority=2,in_port=1,action=output:2' -O OpenFlow13
#sleep 1
#ovs-ofctl add-flow $NAME 'priority=2,in_port=2,action=output:1' -O OpenFlow13

