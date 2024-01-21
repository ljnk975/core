# --------------------------------------------------- -*- Makefile -*- --
# $Id: Makefile,v 1.3 2012/11/27 00:48:37 phil Exp $
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 6.2 (SideWinder)
# 		         version 7.0 (Manzanita)
# 
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.3  2012/11/27 00:48:37  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.2  2012/05/06 05:48:43  phil
# Copyright Storm for Mamba
#
# Revision 1.1  2012/02/01 20:42:59  phil
# Setuptools needed for MYSQL-python build on Rocks v. 6
#
#

PKGROOT		= /opt/rocks
REDHAT.ROOT     = $(CURDIR)/../../
ROCKSROOT       = ../devel/devel
HTTPGET         = ../../src/devel/devel/bin/httpget.sh
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk


build:
# ROCKS8: Creates missing python-blivet package that works with Rocks
# Tests have shown, that blivet-3.3.3 ist the last working version - for whatever reason. Newer
# versions throw weird cyclic dependency errors. Most simple test case for that:
# import blivet
# b = blivet.Blivet()
# blivet-3.3.3 is much newer than the old CentOS7 python-blivet-0.61.15.76. However, RedHat dropped
# support for btrfs for RHEL8 onwards:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/considerations_in_adopting_rhel_8/file-systems-and-storage_considerations-in-adopting-rhel-8
# We need to deactivate btrfs manually. Otherweise warnings like ...
# WARNING **: 16:43:55.608: failed to load module btrfs: libbd_btrfs.so.2: cannot open shared object file: No such file or directory
# ... will appear. Done via patch-file.
ifeq ($(shell ! test -f $(PYPKGNAME)-$(VERSION).tar.gz && echo -n yes),yes)
	@echo "ROCKS8: Sideloading $(PYPKGNAME)-$(VERSION).tar.gz."
	$(HTTPGET) -B $(SRCPKGHOST) -F $(SRCPKGPATH) -n $(PYPKGNAME)-$(VERSION).tar.gz
endif
	gunzip -c $(PYPKGNAME)-$(VERSION).tar.gz | $(TAR) -xf -
	-cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	(								\
		cd $(PYPKGNAME)-$(VERSION);				\
		$(PY.PATH) setup.py build;				\
	)

# Old sources:
# http://vault.centos.org/7.9.2009/updates/Source/SPackages/python-blivet-0.61.15.76-1.el7_9.src.rpm
# https://download.rockylinux.org/pub/rocky/8/AppStream/source/tree/Packages/p/python-blivet-3.6.0-7.el8.src.rpm
# Extract sources from src-rpm and build 
#ifeq ($(shell ! test -f python-blivet-$(VERSION)-$(RELEASE).el8.src.rpm && echo -n yes),yes)
#	@echo "ROCKS8: Sideloading python-blivet-$(VERSION)-$(RELEASE).el8.src.rpm."
#	$(HTTPGET) -B https://download.rockylinux.org -F pub/rocky/8/AppStream/source/tree/Packages/p -n python-blivet-$(VERSION)-$(RELEASE).el8.src.rpm
#endif
#ifeq ($(shell ! test -f python-blivet-$(VERSION)-1.el7_9.src.rpm && echo -n yes),yes)
#	@echo "ROCKS8: python-blivet-$(VERSION)-1.el7_9.src.rpm."
#	$(HTTPGET) -B http://vault.centos.org -F 7.9.2009/updates/Source/SPackages -n python-blivet-$(VERSION)-1.el7_9.src.rpm
#endif
#	(								\
#		mkdir content && cd content;				\
#		rpm2cpio ../python-blivet-$(VERSION)-$(RELEASE).el8.src.rpm | cpio -idmv; \
#		mv $(PYPKGNAME)-$(VERSION)*.tar.gz ../ && cd ..;	\
#		tar xf $(PYPKGNAME)-$(VERSION).tar.gz;			\
#		tar xf $(PYPKGNAME)-$(VERSION)-tests.tar.gz;		\
#		cd $(PYPKGNAME)-$(VERSION);				\
#		PATCHES=`ls ../content/00*`;				\
#		for pat in $$PATCHES; do patch -p1 < $$pat; done;	\
#		cd ../patch-files && find . -type f | grep -v CVS | cpio -pduv ../ && cd ..;\
#		cd $(PYPKGNAME)-$(VERSION);				\
#		$(MAKE) PYTHON=$(PY.PATH);				\
#	)

#	(								\
#		mkdir content && cd content;				\
#		rpm2cpio ../python-blivet-0.61.15.76-1.el7_9.src.rpm | cpio -idmv; \
#		mv $(PYPKGNAME)-$(VERSION).tar.gz ../ && cd ..;		\
#		tar xf $(PYPKGNAME)-$(VERSION).tar.gz;			\
#		cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../ && cd ..;\
#		cd $(PYPKGNAME)-$(VERSION);				\
#		$(MAKE) PYTHON=$(PY.PATH);				\
#	)

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	(								\
		cd $(PYPKGNAME)-$(VERSION);				\
		$(PY.PATH) setup.py install --root=$(ROOT);		\
		rm -f $(ROOT)/etc/dbus-1/system.d/blivet.conf;		\
		rm -f $(ROOT)/usr/lib/systemd/system/blivet.service;	\
		rm -f $(ROOT)/usr/libexec/blivetd;			\
		rm -f $(ROOT)/usr/share/dbus-1/system-services/com.redhat.Blivet0.service;	\
	)
#	(								\
#		cd $(PYPKGNAME)-$(VERSION);				\
#		$(MAKE) PYTHON=$(PY.PATH) DESTDIR=$(ROOT) install;	\
#		rm -f $(ROOT)/etc/dbus-1/system.d/blivet.conf;		\
#		rm -f $(ROOT)/usr/lib/systemd/system/blivet.service;	\
#		rm -f $(ROOT)/usr/libexec/blivetd;			\
#		rm -f $(ROOT)/usr/share/dbus-1/system-services/com.redhat.Blivet0.service;	\
#	)

clean::
	rm -rf $(PYPKGNAME)-$(VERSION)
