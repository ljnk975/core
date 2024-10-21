ifeq ($(strip $(VERSION.MAJOR)), 5)
SSLMK = ssl.mk
else
SSLMK =
endif
ifeq ($(strip $(VERSION.MAJOR)), 6)
GOBJECT =
else
# GOBJECT = gobject-introspection.mk
endif
# include $(GOBOJECT) pygobject.mk pygtk.mk M2Crypto.mk $(SSLMK) numpy.mk pycairo.mk
# ROCKS8 pygobject.mk now separated to foundation-python-pygobject
#        pycairo.mk now separated to foundation-python-pycairo
#        gobject-introspection.mk now separated to foundation-python-gobject-introspection
#        numpy.mk now separated to foundation-python-numpy
#        pygtk.mk now separated to foundation-python-pygtk
include M2Crypto.mk $(SSLMK)
