#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=system-headers
PKG_VERSION:=0.999
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/system-headers
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=system-headers
  DEPENDS:=
endef

define Package/system-headers/description
  contains /usr/include from openwrt buildroot.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Build/Install
endef

define Package/system-headers/install
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) -aR $(STAGING_DIR_ROOT)/usr/include/** $(1)/usr/include/
	$(CP) -aR $(STAGING_DIR_ROOT)/../usr/include/** $(1)/usr/include/
endef

$(eval $(call BuildPackage,system-headers))
