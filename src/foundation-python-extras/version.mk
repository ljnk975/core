NAME	= foundation-python-extras
RELEASE = 0
RPM.EXTRAS="%define _python_bytecompile_errors_terminate_build 0"

ifeq ($(strip $(VERSION.MAJOR)), 7)
EXTRAFILES = "\\n/opt/rocks/include/gobject*\\n/opt/rocks/share/man/man1/*\\n/opt/rocks/lib/[a-oq-zA-Z]*"
else
EXTRAFILES =
endif

RPM.FILES = "/opt/rocks/share/[a-ln-zA-Z]*\\n/opt/rocks/bin/*\\n/opt/rocks/include/pycairo*\\n/opt/rocks/include/pyg*\\n/opt/rocks/include/python2.[67]/*\\n/opt/rocks/lib/pkgconfig/*\\n/opt/rocks/lib/pyg*\\n/opt/rocks/lib/python2.[67]/site-packages/*"

RPM.FILES += $(EXTRAFILES)


ifeq ($(strip $(VERSION.MAJOR)), 8)
# ROCKS8
RPM.FILES="/opt/rocks/bin/*\\n/opt/rocks/lib/python2.7/site-packages/*\\n/opt/rocks/lib/pkgconfig/*\\n/opt/rocks/lib/pygtk/2.0/*\\n/opt/rocks/share/pygtk/2.0/defs/*\\n/opt/rocks/share/gtk-doc/html/pygtk/*\\n/opt/rocks/include/pygtk-2.0/pygtk/*\\n/opt/rocks/include/python2.7/Numeric/*\\n/opt/rocks/include/python2.7/numarray/*"
endif
