# --------------------------------------------------- -*- Makefile -*- --
# $Id: MySQL-python.mk,v 1.16 2013/01/17 17:30:10 clem Exp $
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
# $Log: MySQL-python.mk,v $
# Revision 1.16  2013/01/17 17:30:10  clem
# Set rpath into foundation-mysql libraries
#
# we set the path to load the shared library in /opt/rocks/lib/mysql
# using RPATH instead of the system wide /etc/ld.conf.d/ for all the
# foundation-mysql executables and shared library
#
# Adding this path to the /etc/ld.conf.d/ would change the default beaviour
# of the system mysql which we don't want to happen
#
# http://marc.info/?l=npaci-rocks-discussion&m=135308812922216&w=2
#
# Revision 1.15  2012/11/27 00:48:36  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.14  2012/05/06 05:48:43  phil
# Copyright Storm for Mamba
#
# Revision 1.13  2012/02/24 23:31:12  clem
# wrong sytax used with strip function
#
# Revision 1.12  2012/02/01 20:40:18  phil
# extras to build on 5 and 6. Updated MYSQL-python for use with Pyver 2.6.
#
# Revision 1.11  2011/07/23 02:30:45  phil
# Viper Copyright
#
# Revision 1.10  2010/09/07 23:53:06  bruno
# star power for gb
#
# Revision 1.9  2009/05/01 19:07:06  mjk
# chimi con queso
#
# Revision 1.8  2008/10/18 00:56:00  mjk
# copyright 5.1
#
# Revision 1.7  2008/03/06 23:41:43  mjk
# copyright storm on
#
# Revision 1.6  2007/06/23 04:03:23  mjk
# mars hill copyright
#
# Revision 1.5  2007/01/23 02:17:35  anoop
# Newer version of MySQLdb-python
#
# Revision 1.4  2006/12/06 00:20:21  anoop
# All the Makefiles get a bit of an overhaul
#
# $(INSTALL) is used instead of install
# $(MAKE) is used instead of make or gmake
# $(TAR) is used instead of tar of gtar
#
# The mode argument for the $(INSTALL) command needs to be numeric and
# follow the convention of
#
# install [-cs] [-g group] [-m mode] [-o owner] file ...  destination
# install  -d   [-g group] [-m mode] [-o owner] dir
#
# This is portable across solaris and linux.
#
# Finally "tar xzf $TARFILE.tar.gz" is replaced with "gunzip -c $TARFILE.tar.gz | tar -xf -"
# This is again done for portability.
#
# This needs to be the convention from now on.
#
# Revision 1.3  2006/09/11 22:47:14  mjk
# monkey face copyright
#
# Revision 1.2  2006/08/10 00:09:36  mjk
# 4.2 copyright
#
# Revision 1.1  2006/01/16 23:14:06  mjk
# - more source built foundations
# - scipy stuff is here now (may move to hpc roll)
#

HTTPGET         = ../../src/devel/devel/bin/httpget.sh
ifeq ($(strip $(VERSION.MAJOR)), 5)
MYSQLPYVERSION=1.2.1_p2
else
MYSQLPYVERSION=1.2.5
endif

build::
# ROCKS8: Bump to version 1.2.5 (latest version)
# https://files.pythonhosted.org/packages/a5/e9/51b544da85a36a68debe7a7091f068d802fc515a3a202652828c73453cad/MySQL-python-1.2.5.zip
ifeq ($(shell ! test -f MySQL-python-$(MYSQLPYVERSION).zip && echo -n yes),yes)
	@echo "ROCKS8: Sideloading MySQL-python-$(MYSQLPYVERSION).zip"
	$(HTTPGET) -B https://files.pythonhosted.org -F packages/a5/e9/51b544da85a36a68debe7a7091f068d802fc515a3a202652828c73453cad -n MySQL-python-$(MYSQLPYVERSION).zip
endif
	unzip MySQL-python-$(MYSQLPYVERSION).zip
	#gunzip -c MySQL-python-$(MYSQLPYVERSION).tar.gz | $(TAR) -xf -
	# we need to patch the site.cfg so it will pick up the proper mysql 
	# configuration and we also want to add the rpath in the _mysql.so
	# (so we can remove global /etc/ld.conf include)
	( 								\
		cd MySQL-python-$(MYSQLPYVERSION);			\
		echo "mysql_config=/opt/rocks/mysql/bin/mysql_config" >> site.cfg; \
		export PATH="$(PKGROOT)/bin:$$PATH" ;			\
		export LDFLAGS="-Wl,-rpath,/opt/rocks/mysql/lib" ;	\
		$(PY.PATH) setup.py build;			\
	)
	
install::
	(								\
		cd MySQL-python-$(MYSQLPYVERSION);			\
		PATH=$(PKGROOT)/bin:$$PATH				\
			$(PY.PATH) setup.py install --root=$(ROOT);	\
	)

clean::
	rm -rf MySQL-python-$(MYSQLPYVERSION)
