KICKSTART = centos6-livecd-minimal.ks
CACHE_DIR = $(shell pwd)/rpms
OUTPUT_DIR = $(shell pwd)/out
ISOIMAGE_DIR = $(OUTPUT_DIR)/isoimage

# https://projects.centos.org/trac/livecd/wiki/CreateImage
livecd:
	LANG=C livecd-creator --config=kickstarter/$(KICKSTART) --cache=$(CACHE_DIR)

# http://smorgasbork.com/component/content/article/35-linux/130-building-a-custom-centos-6-kickstart-disc-part-3
installcd:
	wget --mirror -nd --no-parent --no-verbose -R index.html* http://mirror.centos.org/centos-6/6/os/i386/isolinux/ -P isolinux
	# wget --mirror -nd --no-parent --no-verbose -R index.html* http://mirror.centos.org/centos-6/6/os/i386/repodata/ -P repodata-master
	# mkdir -p repodata
	# createrepo -g rpms/base/gen/groups.xml -C $(CACHE_DIR)/createrepo \
	# 	--update --checkts --output repodata rpms
	# rsync -avP isolinux/ $(ISOIMAGE_DIR)
	# mkdir -p $(ISOIMAGE_DIR)/repodata
	# rsync -avP rpms/base/repomd.xml $(ISOIMAGE_DIR)/repodata
	mkdir -p $(OUTPUT_DIR)
	sed -e '/menu default/d' isolinux/isolinux.cfg > $(OUTPUT_DIR)/isolinux.cfg
	echo -e 'label kickstart\n  menu default\n  kernel vmlinuz\n  append initrd=initrd.img ks=cdrom:/$(KICKSTART)' \
		>> $(OUTPUT_DIR)/isolinux.cfg
	mkisofs -o $(OUTPUT_DIR)/$(KICKSTART).iso -b isolinux.bin -c boot.cat -no-emul-boot \
		-boot-load-size 4 -boot-info-table -R -J -v -T -m isolinux/isolinux.cfg \
		isolinux rpms kickstarter/$(KICKSTART) $(OUTPUT_DIR)/isolinux.cfg .discinfo
	implantisomd5 $(OUTPUT_DIR)/$(KICKSTART).iso
	
dep:
	yum install createrepo* deltarpm* python-deltarpm* livecd-tools
