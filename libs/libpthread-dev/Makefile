#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libpthread-dev
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/libpthread-dev
  SECTION:=devel
  CATEGORY:=Development
  SUBMENU:=Libraries
  TITLE:=libpthread-dev
  DEPENDS:=
endef

define Package/libpthread-dev/description
  contains libpthread.a
endef

GCC_VERSION=$(grep -e "PKG_VERSION:=" ../../devel/gcc/Makefile|cut -d "=" -f 2)

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
endef

define Package/libpthread-dev/install
	$(INSTALL_DIR) $(1)/usr/lib/gcc/$(REAL_GNU_TARGET_NAME)/$(GCC_VERSION)
	$(CP) $(TOOLCHAIN_DIR)/lib/libpthread.a $(1)/usr/lib/gcc/$(REAL_GNU_TARGET_NAME)/$(GCC_VERSION)/
endef

$(eval $(call BuildPackage,libpthread-dev))
