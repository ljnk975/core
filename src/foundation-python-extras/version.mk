NAME	= foundation-python-extras
RELEASE = 0
RPM.EXTRAS="%define _python_bytecompile_errors_terminate_build 0"

RPM.FILES = "/opt/rocks/bin/*\\n/opt/rocks/include/*\\n/opt/rocks/lib/*"

