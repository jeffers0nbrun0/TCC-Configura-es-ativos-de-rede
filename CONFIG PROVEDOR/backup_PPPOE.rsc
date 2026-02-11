# jan/14/2026 01:59:43 by RouterOS 6.49.6
# software id = 
#
#
#
/interface bridge
add name=bridge-concentrador protocol-mode=none vlan-filtering=yes
/interface vlan
add comment=CNPJ interface=bridge-concentrador name=VLAN110 vlan-id=110
add comment=CPF interface=bridge-concentrador name=VLAN111 vlan-id=111
add comment=CNPJ interface=bridge-concentrador name=VLAN112 vlan-id=112
add comment=CPF interface=bridge-concentrador name=VLAN113 vlan-id=113
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server
add disabled=no interface=ether2 name=DEBIAN
/ip pool
add name=CGNAT ranges=100.64.0.0/24
/ppp profile
set *0 dns-server=8.8.8.8,1.1.1.1 local-address=100.64.0.1 remote-address=\
    CGNAT
/interface bridge port
add disabled=yes interface=ether10
add disabled=yes interface=ether11
add disabled=yes interface=ether12
add disabled=yes interface=ether13
add disabled=yes interface=*12
add disabled=yes interface=ether1
add bridge=bridge-concentrador interface=ether10
add bridge=bridge-concentrador interface=ether11
/interface bridge vlan
add bridge=bridge-concentrador tagged=bridge-concentrador,ether10 vlan-ids=\
    110
add bridge=bridge-concentrador tagged=bridge-concentrador,ether10 vlan-ids=\
    111
add bridge=bridge-concentrador tagged=bridge-concentrador,ether11 vlan-ids=\
    112
add bridge=bridge-concentrador tagged=bridge-concentrador,ether11 vlan-ids=\
    113
/interface pppoe-server server
add disabled=no interface=VLAN110 service-name=VLAN110
add disabled=no interface=VLAN111 service-name=VLAN111
add disabled=no interface=VLAN112 service-name=VLAN112
add disabled=no interface=VLAN113 service-name=VLAN113
/ip address
add address=10.0.2.2/30 interface=ether1 network=10.0.2.0
/ip dhcp-client
add disabled=no interface=VLAN110
/ip dhcp-server network
add address=10.0.4.0/30 dns-server=8.8.8.8 gateway=10.0.4.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat comment="NAT CGNAT->Borda" out-interface=\
    ether1 src-address=100.64.0.0/24
/ip route
add comment="Default via Borda" distance=1 gateway=10.0.2.1
/ppp secret
add name=farmacia password=123456 service=pppoe
add name=maria password=123456 service=pppoe
add name=supermercado password=123456 service=pppoe
add name=jayane password=123456 service=pppoe
add name=padaria password=123456 service=pppoe
/system identity
set name="CONCENTRADOR PPPOE"
/tool romon
set enabled=yes id=50:1D:1B:00:02:01
