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
# ROCKS8: pyblock (now obsolete) for foundation-anaconda
# http://vault.centos.org/7.9.2009/os/Source/SPackages/python-pyblock-0.53-6.el7.src.rpm
ifeq ($(shell ! test -f dmraid-1.0.0.rc16-3.tar.bz2 && echo -n yes),yes)
	@echo "ROCKS8: Sideloading python-pyblock-0.53-6.el7.src.rpm."
	$(HTTPGET) -B http://vault.centos.org -F 7.9.2009/os/Source/SPackages -n python-pyblock-0.53-6.el7.src.rpm
endif
#	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	(								\
		mkdir content && cd content;				\
		rpm2cpio ../python-pyblock-0.53-6.el7.src.rpm | cpio -idmv && cd ..;	\
		tar xjf content/pyblock-0.53.tar.bz2;			\
		cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../ && cd ..;\
		cd pyblock-0.53;					\
		$(MAKE);						\
	)

install::
	mkdir -p $(ROOT)
	(								\
		cd pyblock-0.53;					\
		$(MAKE) DESTDIR=$(ROOT) SITELIB=/opt/rocks/lib/python2.7/site-packages install;	\
		find $(ROOT) -type f | xargs sed -i '1 s/\/usr\/bin\/python/\/opt\/rocks\/bin\/python/';\
		$(PY.PATH) -m compileall $(ROOT)/$(PKGROOT);		\
		$(PY.PATH) -OO -m compileall $(ROOT)/$(PKGROOT);	\
	)

clean::
	rm -rf pyblock-0.53;						\
	rm -rf content;							\
	rm -f python-pyblock-0.53-6.el7.src.rpm;			\
