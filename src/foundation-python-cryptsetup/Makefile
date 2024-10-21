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
# ROCKS8: cryptsetup for foundation-anaconda
# http://vault.centos.org/7.9.2009/os/Source/SPackages/cryptsetup-2.0.3-6.el7.src.rpm
ifeq ($(shell ! test -f dmraid-1.0.0.rc16-3.tar.bz2 && echo -n yes),yes)
	@echo "ROCKS8: Sideloading cryptsetup-2.0.3-6.el7.src.rpm."
	$(HTTPGET) -B http://vault.centos.org -F 7.9.2009/os/Source/SPackages -n cryptsetup-2.0.3-6.el7.src.rpm
endif
#	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	(								\
		mkdir content && cd content;				\
		rpm2cpio ../cryptsetup-2.0.3-6.el7.src.rpm | cpio -idmv && cd ..;	\
		tar xf content/cryptsetup-1.7.4.tar.xz;				\
		cd cryptsetup-1.7.4;					\
		patch -p1 < ../content/cryptsetup-avoid-rh-kernel-bug.patch;	\
		patch -p1 < ../content/cryptsetup-1.7.5-fix-unaligned-access-to-hidden-truecrypt.patch;	\
		patch -p1 < ../content/cryptsetup-1.7.5-fix-luksformat-in-fips-mode.patch;	\
		patch -p1 < ../content/cryptsetup-1.7.6-fix-blockwise-access-functions-for-64k-page-size.patch;	\
		patch -p1 < ../content/cryptsetup-1.7.6-crypt_deactivate-fail-earlier-when-holders-detected.patch;	\
		PKG_CONFIG_PATH=$(PKGROOT)/lib/pkgconfig PYTHON=$(PY.PATH) \
		LIBS="-L/opt/rocks/lib/" \
		./configure --prefix=$(PKGROOT) --enable-python --enable-fips \
		--disable-pwquality --disable-cryptsetup-reencrypt --disable-veritysetup;	\
		$(MAKE);						\
	)

install::
	mkdir -p $(ROOT)
	(								\
		cd cryptsetup-1.7.4;					\
		$(MAKE) DESTDIR=$(ROOT) install;			\
		rm -rf $(ROOT)/$(PKGROOT)/sbin;				\
		rm -rf $(ROOT)/$(PKGROOT)/share;			\
	)

clean::
	rm -rf cryptsetup-1.7.4;					\
	rm -rf content;							\
	rm -f  cryptsetup-2.0.3-6.el7.src.rpm;				\
