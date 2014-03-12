# Kickstart file automatically generated by anaconda.

#version=DEVEL
install
cdrom
lang en_US.UTF-8
keyboard uk
network --onboot yes --device eth0 --bootproto dhcp
network --onboot yes --device eth1 --bootproto dhcp
rootpw password
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing
timezone --utc Europe/London
bootloader --location=mbr --driveorder=sda,sdb,sdc,sdd --append="crashkernel=auto rhgb quiet"
# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
clearpart --drives=sda
part pv.1 --size 1 --grow --ondrive=sda
volgroup Main pv.1
logvol / --fstype=ext4 --name=Root --vgname=Main --size=20480
logvol /var --fstype=ext4 --name=Var --vgname=Main --size=10240
logvol /home --fstype=ext4 --name=Home --vgname=Main
logvol swap --name=Swap --vgname=Main --size=2048
logvol /tmp --fstype=ext4 --name=Temp --vgname=Main --size=10240

repo --name=base   --baseurl=http://mirror.centos.org/centos-6/6/os/$basearch/
# repo --name="CentOS"  --baseurl=cdrom:sr0 --cost=100

%packages
@base
@console-internet
@core
@debugging
@directory-client
@hardware-monitoring
@java-platform
@large-systems
@network-file-system-client
@performance
@perl-runtime
@server-platform
@server-policy
pax
oddjob
sgpio
certmonger
pam_krb5
krb5-workstation
perl-DBD-SQLite
%end
