NAME = foundation-git
VERSION = 2.43.0
RELEASE = 0
RPM.EXTRAS=%define __os_install_post /usr/lib/rpm/redhat/brp-compress; /usr/lib/rpm/redhat/brp-strip-static-archive %{__strip}; /usr/lib/rpm/redhat/brp-python-hardlink;%{!?__jar_repack:/usr/lib/rpm/redhat/brp-java-repack-jars}

RPM.FILES="/opt/rocks/bin/*\\n/opt/rocks/etc/*\\n/opt/rocks/libexec/git-core\\n/opt/rocks/share/git-gui\\n/opt/rocks/share/gitk\\n/opt/rocks/share/git-core\\n/opt/rocks/share/gitweb\\n/opt/rocks/share/locale/*/LC_MESSAGES\\n/opt/rocks/share/man/man[157]/*\\n/opt/rocks/share/perl5\\n"

