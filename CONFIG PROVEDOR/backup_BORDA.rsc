# 2026-01-14 02:20:29 by RouterOS 7.17
# system id = qzLO8VWLXGF
#
/interface list
add name=WAN
add name=GERENCIA
/ip pool
add name=dhcp_pool0 ranges=10.0.3.2
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether3 lease-time=10m name=dhcp1
/port
set 0 name=serial0
set 1 name=serial1
/interface list member
add interface=ether1 list=WAN
add interface=ether2 list=GERENCIA
/ip address
add address=192.168.2.4/29 comment="WAN - OPERADORA" interface=ether1 \
    network=192.168.2.0
add address=10.0.2.1/30 comment="Link PPPoE2" interface=ether2 network=\
    10.0.2.0
add address=10.0.1.1/30 interface=ether3 network=10.0.1.0
/ip dhcp-server network
add address=10.0.3.0/30 gateway=10.0.3.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT clientes para a Operadora" \
    disabled=yes out-interface=ether1
add action=masquerade chain=srcnat comment="NAT PPPoE->WAN" out-interface=\
    ether1 src-address=10.0.2.0/30
add action=masquerade chain=srcnat comment="NAT ZABBIX>WAN" out-interface=\
    ether1 src-address=10.0.1.0/30
/ip route
add comment="ROTA PADR\C3O" disabled=no distance=1 dst-address=0.0.0.0/0 \
    gateway=192.168.2.1 routing-table=main scope=30 suppress-hw-offload=no \
    target-scope=10
/system identity
set name=BORDA
/system logging
add topics=dhcp
/system note
set show-at-login=no
/tool romon
set enabled=yes id=50:1D:1B:00:01:00
