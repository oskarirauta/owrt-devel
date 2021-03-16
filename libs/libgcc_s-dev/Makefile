#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libgcc_s-dev
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/libgcc_s-dev
  SECTION:=devel
  CATEGORY:=Development
  SUBMENU:=Libraries
  TITLE:=libgcc_s-dev
  DEPENDS:=
endef

define Package/libgcc_s-dev/description
  contains lib/libgcc_s_pic.a and lib/libgcc_s_pic.map
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
endef

define Package/libgcc_s-dev/install
	$(INSTALL_DIR) $(1)/lib
	$(CP) $(STAGING_DIR_ROOT)/lib/libgcc_s_pic.a $(1)/lib/
	$(CP) $(STAGING_DIR_ROOT)/lib/libgcc_s_pic.map $(1)/lib/
endef

$(eval $(call BuildPackage,libgcc_s-dev))
