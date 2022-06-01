#!/bin/bash

echo ttyS0 >> /etc/securetty

echo "GRUB_TERMINAL=serial" >> /etc/default/grub
echo 'GRUB_SERIAL_COMMAND="serial --unit=0 --speed=115200 --word=8 --parity=no --stop=1"' >> /etc/default/grub

sed -i "s/quiet splash/splash console=ttyS0/g" /etc/default/grub > /dev/null

update-grub

systemctl enable serial-getty@ttyS0.service && systemctl start serial-getty@ttyS0.service

reboot