# 2026-01-14 22:31:51 by RouterOS 7.17
# system id = IpBl5dXhXXH
#
/interface bridge
add name=BRIDGE-VLAN vlan-filtering=yes
add name=REDE-LAN
/interface vlan
add interface=BRIDGE-VLAN name=VLAN112 vlan-id=112
/interface pppoe-client
add add-default-route=yes disabled=no interface=VLAN112 name=PPPOE \
    use-peer-dns=yes user=lanchonete
/ip pool
add name=POOL-LAN ranges=192.168.0.2-192.168.0.254
/port
set 0 name=serial0
set 1 name=serial1
/interface bridge port
add bridge=BRIDGE-VLAN interface=ether1
add bridge=REDE-LAN interface=ether2
add bridge=REDE-LAN interface=ether3
add bridge=REDE-LAN interface=ether4
/interface bridge vlan
add bridge=BRIDGE-VLAN tagged=BRIDGE-VLAN,ether1 vlan-ids=112
/ip address
add address=192.168.0.1/24 interface=REDE-LAN network=192.168.0.0
/ip dhcp-client
# DHCP client can not run on slave or passthrough interface!
add interface=ether1
add disabled=yes interface=ether1
add disabled=yes interface=ether1
/ip dhcp-server
add address-pool=POOL-LAN interface=REDE-LAN name=DHCP-LAN
/ip dhcp-server config
set store-leases-disk=never
/ip dhcp-server network
add address=192.168.0.0/24 dns-server=8.8.8.8 gateway=192.168.0.1
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT LAN" out-interface=PPPOE
add action=masquerade chain=srcnat comment="NAT LAN" out-interface=PPPOE
/system clock
set time-zone-name=America/Recife
/system identity
set name=lanchonete
/system note
set show-at-login=no
/tool romon
set enabled=yes
