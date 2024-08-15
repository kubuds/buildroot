################################################################################
#
# ustreamer
#
################################################################################

USTREAMER_VERSION = 6.11
USTREAMER_SITE = $(call github,pikvm,ustreamer,v$(USTREAMER_VERSION))
USTREAMER_LICENSE = GPL-3.0+
USTREAMER_LICENSE_FILES = LICENSE
USTREAMER_DEPENDENCIES = jpeg libevent libbsd

USTREAMER_MAKE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	WITH_PTHREAD_NP=0 \
	WITH_SETPROCTITLE=1 \
	HAS_PDEATHSIG=1

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
USTREAMER_MAKE_OPTS += WITH_SYSTEMD=1
USTREAMER_DEPENDENCIES += systemd
endif

ifeq ($(BR2_PACKAGE_LIBGPIOD),y)
USTREAMER_MAKE_OPTS += WITH_GPIO=1
USTREAMER_DEPENDENCIES += libgpiod
endif

ifeq ($(BR2_PACKAGE_LIBGPIOD2),y)
USTREAMER_MAKE_OPTS += WITH_GPIO=1
USTREAMER_DEPENDENCIES += libgpiod2
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
USTREAMER_MAKE_OPTS += WITH_PYTHON=1
USTREAMER_DEPENDENCIES += host-python-setuptools host-python-pip host-python-wheel python3
endif

define USTREAMER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(USTREAMER_MAKE_OPTS) -C $(@D)
endef

define USTREAMER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/ustreamer \
		$(TARGET_DIR)/usr/bin/ustreamer
	$(INSTALL) -D -m 0755 $(@D)/ustreamer-dump \
		$(TARGET_DIR)/usr/bin/ustreamer-dump
endef

$(eval $(generic-package))
