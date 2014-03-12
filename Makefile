KICKSTART = centos6-livecd-minimal.ks
CACHE_DIR = $(shell pwd)/yum-cache

# https://projects.centos.org/trac/livecd/wiki/CreateImage
livecd:
	LANG=C livecd-creator --config=kickstarter/$(KICKSTART) --fslabel=$(KICKSTART) --cache=$(CACHE_DIR)

# http://smorgasbork.com/component/content/article/35-linux/130-building-a-custom-centos-6-kickstart-disc-part-3
installcd:
	wget --mirror -nd --no-parent --no-verbose -R index.html* http://mirror.centos.org/centos-6/6/os/i386/isolinux/ -P isolinux
	
dep:
	yum install createrepo* deltarpm* python-deltarpm* livecd-tools
