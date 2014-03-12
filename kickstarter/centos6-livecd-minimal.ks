lang en_US.UTF-8
keyboard us
timezone US/Eastern
auth --useshadow --enablemd5
selinux --enforcing
firewall --disabled
repo --name=base   --baseurl=http://mirror.centos.org/centos-6/6/os/$basearch/

%packages
@core
anaconda-runtime
bash
kernel
syslinux
passwd
policycoreutils
chkconfig
authconfig
rootfiles

%end
