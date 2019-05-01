# docker-vnf
Virtual Network Functions as Docker containers (ideal for vim-emu/CaaS)

## ubuntu-sshd

Simple ubuntu container with sshd installed. Used for testing (ships with tcpdump, iperf and netcat)

## firewall

Simple one-way firewall based on iptables. Interfaces are fwin-0 and fwout-0.

## snort

Snort VNF configured for out of band monitoring. Packets have to be mirrored to the VNF (using iptables TEE module for example). Rules are in /etc/snort/rules/local.rules

## vim-boilerplate

Base Dockerfile for vim-emu containers, with needed package and a special entrypoint for the emulator gatekeeper. See [vim-emu : A NFV multi-PoP emulation platform](https://osm.etsi.org/wikipub/index.php/VIM_emulator)

## OSM-descriptors

Contains OSM descriptors for Virtual Network Functions (VNF) and Network Services (NS).

See the OSM Information Model (IM) for [NSD](http://osm-download.etsi.org/repository/osm/debian/ReleaseFIVE/docs/osm-im/osm_im_trees/nsd.html) and [VNFD](http://osm-download.etsi.org/repository/osm/debian/ReleaseFIVE/docs/osm-im/osm_im_trees/vnfd.html)
