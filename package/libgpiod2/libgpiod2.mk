################################################################################
#
# libgpiod2
#
################################################################################

# Be careful when bumping versions.
# Dependency on kernel header versions may change.
LIBGPIOD2_VERSION = 2.1.3
LIBGPIOD2_SOURCE = libgpiod-$(LIBGPIOD2_VERSION).tar.xz
LIBGPIOD2_SITE = https://www.kernel.org/pub/software/libs/libgpiod
LIBGPIOD2_LICENSE = LGPL-2.1+
LIBGPIOD2_LICENSE_FILES = COPYING
LIBGPIOD2_INSTALL_STAGING = YES
LIBGPIOD2_DEPENDENCIES = host-pkgconf
LIBGPIOD2_CONF_OPTS = \
	--disable-examples \
	--disable-tests

ifeq ($(BR2_PACKAGE_LIBGPIOD2_TOOLS),y)
LIBGPIOD2_CONF_OPTS += --enable-tools
else
LIBGPIOD2_CONF_OPTS += --disable-tools
endif

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
LIBGPIOD2_CONF_OPTS += --enable-bindings-cxx
else
LIBGPIOD2_CONF_OPTS += --disable-bindings-cxx
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
LIBGPIOD2_CONF_OPTS += --enable-bindings-python
LIBGPIOD2_DEPENDENCIES += python3 host-python-setuptools
LIBGPIOD2_CONF_ENV += \
	PYTHON=$(HOST_DIR)/bin/python3 \
	PYTHON_CPPFLAGS="`$(STAGING_DIR)/usr/bin/python3-config --includes`" \
	PYTHON_LIBS="`$(STAGING_DIR)/usr/bin/python3-config --ldflags`"
else
LIBGPIOD2_CONF_OPTS += --disable-bindings-python
endif

$(eval $(autotools-package))
