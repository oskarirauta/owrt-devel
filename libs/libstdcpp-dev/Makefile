#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libstdcpp-dev
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/libstdcpp-dev
  SECTION:=devel
  CATEGORY:=Development
  SUBMENU:=Libraries
  TITLE:=libstdcpp-dev
  DEPENDS:=
endef

define Package/libstdcpp-dev/description
  contains /lib/libstdc++.a, /lib/libstdc++fs.a and /lib/libsupc++.a
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
endef

define Package/libstdcpp-dev/install
	$(INSTALL_DIR) $(1)/lib
	$(CP) $(STAGING_DIR_ROOT)/lib/libstdc++.a $(1)/lib/
	$(CP) $(STAGING_DIR_ROOT)/lib/libstdc++fs.a $(1)/lib/
	$(CP) $(STAGING_DIR_ROOT)/lib/libsupc++.a $(1)/lib/
endef

$(eval $(call BuildPackage,libstdcpp-dev))
