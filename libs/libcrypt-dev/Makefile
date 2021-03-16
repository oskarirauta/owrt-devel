#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libcrypt-dev
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/libcrypt-dev
  SECTION:=devel
  CATEGORY:=Development
  SUBMENU:=Libraries
  TITLE:=libcrypt-dev
  DEPENDS:=@TARGET_x86_64
endef

define Package/libcrypt-dev/description
  contains libcrypt.a
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
	mkdir -p $(PKG_INSTALL_DIR)
endef

define Package/libcrypt-dev/install
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_BIN) $(STAGING_DIR_ROOT)/lib/libcrypt.a $(1)/lib/
endef

$(eval $(call BuildPackage,libcrypt-dev))
