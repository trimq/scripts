#!/bin/bash

#### Variables

IP_CHECKMK_SERVER=$1

#### Download Package

echo "Download CheckMK & Xinetd"

sleep 3

wget https://check.cloud365.vn/admin/check_mk/agents/check-mk-agent-1.5.0p9-1.noarch.rpm

yum install xinetd -y

#### Giai nen

echo "Install Check-mk-agent"

sleep 3

rpm -ivh check-mk-agent-1.5.0p9-1.noarch.rpm

#### Cai dat

echo "Config check-mk-agent"

cp /etc/xinetd.d/check_mk /etc/xinetd.d/check_mk.orig

sed -i 's/#only_from      = 127.0.0.1 10.0.20.1 10.0.20.2/only_from      = '$IP_CHECKMK_SERVER'/g'  /etc/xinetd.d/check_mk

#### Khoi dong dich vu

echo "Restaring xinetd"

sleep 3

systemctl restart xinetd && systemctl enable xinetd

#### Add rule firewall

echo "Add rule firewall for port 6556"

sleep 3

iptables -I INPUT -p tcp -m tcp --dport 6556 -j ACCEPT

echo "Finish"

