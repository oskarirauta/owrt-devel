#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsetlbf-dev
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DEPENDS:=procd

define Package/libsetlbf-dev
  SECTION:=devel
  CATEGORY:=Development
  SUBMENU:=Libraries
  TITLE:=libsetlbf-dev
  DEPENDS:=
endef

define Package/libsetlbf-dev/description
  contains /lib/libsetlbf.a
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
endef

define Package/libsetlbf-dev/install
	$(INSTALL_DIR) $(1)/lib
	$(CP) $(STAGING_DIR_ROOT)/lib/libsetlbf.a $(1)/lib/
endef

$(eval $(call BuildPackage,libsetlbf-dev))
