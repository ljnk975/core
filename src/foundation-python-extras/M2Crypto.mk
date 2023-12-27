#
# $Id: M2Crypto.mk,v 1.6 2012/11/27 00:48:36 phil Exp $
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
# $Log: M2Crypto.mk,v $
# Revision 1.6  2012/11/27 00:48:36  phil
# Copyright Storm for Emerald Boa
#
# Revision 1.5  2012/05/06 05:48:43  phil
# Copyright Storm for Mamba
#
# Revision 1.4  2012/01/23 20:02:44  phil
# Update M2Crypto version. fix build bugs on 6 for M2Crypto and SSL
#
# Revision 1.3  2011/07/23 02:30:45  phil
# Viper Copyright
#
# Revision 1.2  2010/09/07 23:53:06  bruno
# star power for gb
#
# Revision 1.1  2010/06/21 22:46:45  bruno
# more helper libraries for the VM remote control code
#
#

HTTPGET         = ../../src/devel/devel/bin/httpget.sh
OPENSSL_PREFIX	= /opt/rocks
#M2DEFS		= -DOPENSSL_NO_EC
# EC already deactivated in OpenSSL 1.0.2u
M2OPTIONS	= build_ext $(M2DEFS)
CRYPTOVERSION	= 0.26.0
# 0.26.0 is last version with OpenSSL 1.0.x API (https://gitlab.com/m2crypto/m2crypto/-/blob/master/CHANGES#L230)

build::
# ROCKS8: Bump to version 0.26.0
# https://files.pythonhosted.org/packages/11/29/0b075f51c38df4649a24ecff9ead1ffc57b164710821048e3d997f1363b9/M2Crypto-0.26.0.tar.gz
ifeq ($(shell ! test -f M2Crypto-$(CRYPTOVERSION).tar.gz && echo -n yes),yes)
	@echo "ROCKS8: Sideloading M2Crypto-$(CRYPTOVERSION).tar.gz."
	$(HTTPGET) -B https://files.pythonhosted.org -F packages/11/29/0b075f51c38df4649a24ecff9ead1ffc57b164710821048e3d997f1363b9 -n M2Crypto-$(CRYPTOVERSION).tar.gz
endif
	gunzip -c M2Crypto-$(CRYPTOVERSION).tar.gz | $(TAR) -xf -
	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	(												\
		cd M2Crypto-$(CRYPTOVERSION);								\
		SWIG_FEATURES="-cpperraswarn $(M2DEFS)" $(PY.PATH) setup.py build $(M2OPTIONS);		\
	)

# header renaming unnecessary due to custom openssl build
#		for f in `find . -exec grep -l opensslconf.h {} 2>/dev/null \;`;  	\
#		do 						\
#		    sed -i "s/opensslconf.h/opensslconf-$(ARCH).h/" $$f; \
#		done; 	\
	
install::
	(												\
		cd M2Crypto-$(CRYPTOVERSION);								\
		$(PY.PATH) setup.py $(M2OPTIONS) install --root=$(ROOT); 				\
	)


clean::
	rm -rf M2Crypto-$(CRYPTOVERSION)

