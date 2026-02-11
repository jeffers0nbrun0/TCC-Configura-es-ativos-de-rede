# jan/14/2026 02:19:19 by RouterOS 6.49.6
# software id = 
#
#
#
/interface bridge
add name=bridge-passagem protocol-mode=none vlan-filtering=yes
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge-passagem interface=all
/interface bridge vlan
add bridge=bridge-passagem tagged=\
    bridge-passagem,ether1,ether2,ether3,ether4,ether5,ether6,ether7,ether8 \
    vlan-ids=110
add bridge=bridge-passagem tagged=\
    bridge-passagem,ether1,ether2,ether3,ether4,ether5,ether6,ether7,ether8 \
    vlan-ids=111
/ip dhcp-client
add interface=ether1
/ip route
add distance=1 gateway=10.0.4.1
/system identity
set name="OLT 01"
/tool romon
set enabled=yes id=50:A7:35:00:04:01
