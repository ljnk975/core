# --------------------------------------------------- -*- Makefile -*- --
# $Id: numpy.mk,v 1.13 2012/11/27 00:48:36 phil Exp $
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
#

HTTPGET         = ../../src/devel/devel/bin/httpget.sh
vers = 1.3.2

build::
# ROCKS8: Bump to version 1.3.2 (same as on Rocky8)
# https://files.pythonhosted.org/packages/2a/9b/9b8aa2d5dbe2e4052cb4c84b8cf5e31686943f24b0565f436439bdc343b5/SQLAlchemy-1.3.2.tar.gz
ifeq ($(shell ! test -f SQLAlchemy-$(vers).tar.gz && echo -n yes),yes)
	@echo "ROCKS8: Sideloading SQLAlchemy-$(vers).tar.gz."
	$(HTTPGET) -B https://files.pythonhosted.org -F packages/2a/9b/9b8aa2d5dbe2e4052cb4c84b8cf5e31686943f24b0565f436439bdc343b5 -n SQLAlchemy-$(vers).tar.gz
endif
	gunzip -c SQLAlchemy-$(vers).tar.gz | $(TAR) -xf -
	(								\
		cd SQLAlchemy-$(vers);						\
		$(PY.PATH) setup.py build;				\
	)
	
install::
	(								\
		cd SQLAlchemy-$(vers);						\
		$(PY.PATH) setup.py install --root=$(ROOT);		\
	)


clean::
	rm -rf SQLAlchemy-$(vers)
