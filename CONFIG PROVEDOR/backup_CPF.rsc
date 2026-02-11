# jan/14/2026 01:23:02 by RouterOS 6.49.6
# software id = 
#
#
#

# CONFIGURA AS INTERFACES BRIDGE
/interface bridge
add name=BRIDGE-VLAN protocol-mode=none vlan-filtering=yes
add name=REDE-LAN

# CRIA A VLAN E VINCULA A INTERFACE BRIDGE-VLAN
/interface vlan
add interface=BRIDGE-VLAN name=VLAN111 vlan-id=111

# CONFIGURA O PPPOE CLIENTE
/interface pppoe-client
add add-default-route=yes disabled=no interface=VLAN111 name=PPPOE password=\
    123456 use-peer-dns=yes user=maria
    
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=POOL-LAN ranges=192.168.0.2-192.168.0.254
/ip dhcp-server
add address-pool=POOL-LAN disabled=no interface=REDE-LAN name=DHCP-LAN
/interface bridge port
add bridge=BRIDGE-VLAN interface=ether1
add bridge=REDE-LAN interface=ether2
add bridge=REDE-LAN interface=ether3
add bridge=REDE-LAN interface=ether4
/interface bridge vlan
add bridge=BRIDGE-VLAN tagged=BRIDGE-VLAN,ether1 vlan-ids=111
/ip address
add address=192.168.0.1/24 interface=REDE-LAN network=192.168.0.0
/ip dhcp-server config
set store-leases-disk=never
/ip dhcp-server network
add address=192.168.0.0/24 dns-server=8.8.8.8 gateway=192.168.0.1
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT LAN" out-interface=PPPOE
/system identity
set name=Maria
/system logging
add disabled=yes topics=dhcp
/tool romon
set enabled=yes
/user add name=jeffersonbruno password="Bruno200@@" group=full comment="NOC"
/user set [find name="admin"] password="Bruno200@@"

