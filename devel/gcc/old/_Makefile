#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gcc
PKG_VERSION:=10.2.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://dev.alpinelinux.org/~nenolog/
PKG_HASH:=616ec0762b1870e012ecfec74101ce3928fcc7eb3c7b57fa0d8642ac9899fef7

include $(INCLUDE_DIR)/package.mk

PKG_CPE_ID:=cpe:/a:gnu:gcc
PKG_FIXUP:=libtool
PKG_BUILD_PARALLEL:=0
#PKG_INSTALL:=1

define Package/gcc
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=gcc
  MAINTAINER:=Noble Pepper <gccmaintain@noblepepper.com>
  DEPENDS:= +binutils +libpthread +libzstd @!arc
  MENU:=1
endef

define Package/gcc/description
  Build a native toolchain for compiling on target
  device.
endef

TARGET_LANGUAGES:="c,c++,go,fortran"
BUGURL=https://dev.openwrt.org/
PKGVERSION=OpenWrt GCC $(PKG_VERSION)
#TARGET_CPPFLAGS += -D_GLIBCXX_INCLUDE_NEXT_C_HEADERS
#TARGET_LDFLAGS += -Wl,-rpath-link=$(STAGING_DIR)/lib -Wl,-rpath-link=$(STAGING_DIR)/usr/lib -Wl,-rpath-link=$(TOOLCHAIN)/lib -Wl,--dynamic-linker=$(STAGING_DIR)/lib -L$(TOOLCHAIN_DIR)/lib, -lstdc++

# not using sstrip here as this fucks up the .so's somehow
#STRIP:=$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)strip
#RSTRIP:= \
#	NM="$(TOOLCHAIN_DIR)/bin/$(TARGET_CROSS)nm" \
#	STRIP="$(STRIP)" \
#	STRIP_KMOD="$(STRIP) --strip-debug" \
#	$(SCRIPT_DIR)/rstrip.sh

GMPSRC=gmp-6.1.0

define Download/gmp
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(GMPSRC).tar.bz2
  HASH:=498449a994efeba527885c10405993427995d3f86b8768d8cdf8d9dd7c6b73e8
endef
$(eval $(call Download,gmp))

MPCSRC=mpc-1.0.3

define Download/mpc
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPCSRC).tar.gz
  HASH:=617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3
endef
$(eval $(call Download,mpc))

MPFRSRC=mpfr-3.1.4

define Download/mpfr
  URL:=ftp://gcc.gnu.org/pub/gcc/infrastructure/
  FILE:=$(MPFRSRC).tar.bz2
  HASH:=d3103a80cdad2407ed581f3618c4bed04e0c92d1cf771a65ead662cc397f7775
endef
$(eval $(call Download,mpfr))

define Build/Prepare
	$(PKG_UNPACK)
# 	we have to download and unpack additional stuff before patching
	tar -C $(PKG_BUILD_DIR) -xvjf $(DL_DIR)/$(GMPSRC).tar.bz2
	ln -sf $(PKG_BUILD_DIR)/$(GMPSRC) $(PKG_BUILD_DIR)/gmp
	tar -C $(PKG_BUILD_DIR) -xvzf $(DL_DIR)/$(MPCSRC).tar.gz
	ln -sf $(PKG_BUILD_DIR)/$(MPCSRC) $(PKG_BUILD_DIR)/mpc
	tar -C $(PKG_BUILD_DIR) -xvjf $(DL_DIR)/$(MPFRSRC).tar.bz2
	ln -sf $(PKG_BUILD_DIR)/$(MPFRSRC) $(PKG_BUILD_DIR)/mpfr
	$(Build/Patch)
#	poor man's fix for `none-openwrt-linux' not recognized when building with musl
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpfr/
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/gmp/
	chmod u+w $(PKG_BUILD_DIR)/mpc/config.sub
	cp $(PKG_BUILD_DIR)/config.sub $(PKG_BUILD_DIR)/mpc/
	$(INSTALL_DIR) $(PKG_BUILD_DIR)/host-$(REAL_GNU_TARGET_NAME)
	$(INSTALL_DIR) $(PKG_BUILD_DIR)/build-$(GNU_HOST_NAME)
	ln -s ../$(REAL_GNU_TARGET_NAME) $(PKG_BUILD_DIR)/host-$(REAL_GNU_TARGET_NAME)/$(REAL_GNU_TARGET_NAME)
	ln -s ../$(REAL_GNU_TARGET_NAME) $(PKG_BUILD_DIR)/build-$(GNU_HOST_NAME)/$(REAL_GNU_TARGET_NAME)
endef

#CONFIGURE_ARGS +=  CXXFLAGS_FOR_TARGET="-g -O2 -D_GLIBCXX_INCLUDE_NEXT_C_HEADERS" LDFLAGS_FOR_TARGET="-L$(STAGING_DIR_ROOT)/lib"
#MAKE_VARS += libat_cv_have_ifunc=no gcc_cv_libc_provides_ssp=yes

#libm.a disabled
LDFLAGS_FOR_TARGET=-L$(TOOLCHAIN_DIR)/lib $(TOOLCHAIN_DIR)/lib/libc.so $(TOOLCHAIN_DIR)/lib/libstdc++.so.6.0.28 $(TOOLCHAIN_DIR)/lib/libgcc_s.so.1 -L$(STAGING_DIR)/lib -L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR_ROOT)/lib -Wl,--gc-sections,--as-needed -Wl,-z,relro,-z,now

CONFIGURE_VARS = \
		$(TARGET_CONFIGURE_OPTS) \
		libat_cv_have_ifunc=no \
		gcc_cv_libc_provides_ssp=yes \
		LDFLAGS="$(LDFLAGS_FOR_TARGET)" \
		LDFLAGS_FOR_TARGET="$(LDFLAGS_FOR_TARGET)"
		
CONFIGURE_ARGS += \
		--build=$(GNU_HOST_NAME) \
		--host=$(REAL_GNU_TARGET_NAME) \
		--target=$(REAL_GNU_TARGET_NAME) \
		--enable-languages=$(TARGET_LANGUAGES) \
		--with-bugurl=$(BUGURL) \
		--with-pkgversion="$(PKGVERSION)" \
		--enable-shared \
		$(if $(CONFIG_LIBC_USE_GLIBC),--enable,--disable)-__cxa_atexit \
		--with-default-libstdcxx-abi=gcc4-compatible \
		--enable-target-optspace \
		--with-gnu-ld \
		--disable-fixed-point \
		--disable-libstdcxx-pch \
		--disable-multilib \
		--disable-nls \
		--disable-werror \
		--disable-symvers \
		--enable-__cxa_atexit \
		--enable-default-pie \
		--enable-default-ssp \
		--enable-cloog-backend \
		--enable-languages="c,c++,go" \
		--disable-libada \
		--disable-libssp \
		--disable-libmpx \
		--disable-libmudflap \
		--disable-libsanitizer \
		--disable-sanitizer \
		--disable-bootstrap \
		--enable-shared \
		--enable-threads \
		--enable-tls \
		--enable-lto \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-libvtv \
		--disable-libcilkrts \
		--with-host-libstdxx="$(LDFLAGS_FOR_TARGET)" \
		--prefix=/usr \
		--libexecdir=/usr/lib \
		--with-local-prefix=/usr \
		--with-stage1-ldflags="$(LDFLAGS_FOR_TARGET)" \
		$(ARM_FLOAT_OPTION) \
		$(SOFT_FLOAT_CONFIG_OPTION) \
		$(call qstrip,$(CONFIG_EXTRA_GCC_CONFIG_OPTIONS))

#-lstdc++

MAKE_VARS += \
		libat_cv_have_ifunc=no \
		gcc_cv_libc_provides_ssp=yes

#TARGET_LDFLAGS += \
#		-lc $(TOOLCHAIN_DIR)/lib/libc.so \
#		-lm $(TOOLCHAIN_DIR)/lib/libm.a \
#		-lstdc++ $(TOOLCHAIN_DIR)/lib/libstdc++.so.6.0.28 \
#		-lgcc_s $(TOOLCHAIN_DIR)/lib/libgcc_s.so.1 \
#		-Wl,--gc-sections,--as-needed \
#		-Wl,-z,relro,-z,now

MAKE_FLAGS += $(MAKE_ARGS) DESTDIR="$(PKG_INSTALL_DIR)" all install
#MAKE_INSTALL_FLAGS += $(MAKE_ARGS)

#TARGET_CFLAGS += \
#	-I$(TOOLCHAIN_DIR)/include

#TARGET_CXXFLAGS = \
#	-Os -pipe -fno-caller-saves -fno-plt -Wno-error=unused-but-set-variable -Wno-error=unused-result \ 
#	-fmacro-prefix-map=$(STAGING_DIR)/gcc-10.2.1=gcc-10.2.1 -Wformat -Werror=format-security \
#	-fstack-protector -D_FORTIFY_SOURCE=1 -Wl,-z,now -Wl,-z,relro

#TARGET_CXXFLAGS += \
#	-I$(TOOLCHAIN_DIR)/include

#TARGET_CPPFLAGS += \
#	-I$(TOOLCHAIN_DIR)/include

#TARGET_LDFLAGS += \
#	-L$(STAGING_DIR)/lib -L$(STAGING_DIR)/usr/lib \
#	-L$(STAGING_DIR_ROOT)/lib -L$(STAGING_DIR_ROOT)/usr/lib

#--with-stage1-ldflags="-L$(STAGING_DIR_ROOT)/lib -lstdc++"
#--with-build-sysroot=$(STAGING_DIR_ROOT)
#$(ARM_FLOAT_OPTION)
#$(SOFT_FLOAT_CONFIG_OPTION)

define Build/Configure
	$(RM) -f $(PKG_BUILD_DIR)/config.cache
	$(call Build/Configure/Default)
endef

#define Build/Compile
#	export SHELL="$(BASH)"; $(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR)/$(MAKE_PATH) \
#			DESTDIR="$(PKG_INSTALL_DIR)" $(MAKE_FLAGS) $(MAKE_ARGS) all install
#endef

#ENVCFLAGS:="$(TARGET_OPTIMIZATION) $(EXTRA_OPTIMIZATION)
#ifeq ($(CONFIG_SOFT_FLOAT),y)
#    ifeq ($(CONFIG_arm),y)
#	ENVCFLAGS+= -mfloat-abi=soft
#    else
#	ENVCFLAGS+= -msoft-float
#    endif
#endif

#ENVLDFLAGS:="-Wl,-rpath=/usr/lib -Wl,--dynamic-linker=/usr/lib/$(DYNLINKER) -L/usr/lib, -lstdc++"
#ENVLDFLAGS:=-Wl,-rpath-link=$(STAGING_DIR)/lib -Wl,-rpath-link=$(STAGING_DIR)/usr/lib -Wl,-rpath-link=$(TOOLCHAIN)/lib -Wl,--dynamic-linker=$(STAGING_DIR)/lib -L$(TOOLCHAIN_DIR)/lib, -lstdc++

define Package/gcc/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -ar $(PKG_INSTALL_DIR)/usr/include $(1)/usr
	cp -a $(PKG_INSTALL_DIR)/usr/bin/$(REAL_GNU_TARGET_NAME)-{c++,g++,gcc-ar,gcc-nm,gcc-ranlib,gccgo,gcc-$(PKG_VERSION)} $(1)/usr/bin/

	ln -s $(REAL_GNU_TARGET_NAME)-c++ $(1)/usr/bin/c++
	ln -s $(REAL_GNU_TARGET_NAME)-g++ $(1)/usr/bin/g++
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-$(PKG_VERSION) $(1)/usr/bin/$(REAL_GNU_TARGET_NAME)-gcc
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-$(PKG_VERSION) $(1)/usr/bin/gcc
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-ar $(1)/usr/bin/gcc-ar
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-nm $(1)/usr/bin/gcc-nm
	ln -s $(REAL_GNU_TARGET_NAME)-gcc-ranlib $(1)/usr/bin/gcc-ranlib
	ln -s $(REAL_GNU_TARGET_NAME)-gccgo $(1)/usr/bin/gccgo

	cp -a $(PKG_INSTALL_DIR)/usr/bin/{gcov,gcov-dump,gcov-tool,go,gofmt,lto-dump} $(1)/usr/bin/

	cp -ar $(PKG_INSTALL_DIR)/usr/lib/** $(1)/usr/lib/
	cp -ar $(TOOLCHAIN_DIR)/include $(1)/usr
	cp -a $(TOOLCHAIN_DIR)/lib/*.{o,so*} $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -a $(TOOLCHAIN_DIR)/lib/*nonshared*.a  $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	cp -a $(TOOLCHAIN_DIR)/lib/libm.a  $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)
	#rm -f $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libgo*
	rm -f $(1)/usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/libcc1*
	$(INSTALL_BIN) ./files/gcc_env.sh $(1)/usr/bin/gcc_env.sh
	#use sed to inject variables to gcc_env.sh
	chmod +x $(1)/usr/bin/gcc_env.sh
endef

define Package/gcc/postinst
	#!/bin/sh
	g++ -dumpspecs |sed s/--start-group}\ %G\ %L\ /--start-group}\ %G\ %L\ -lstdc++\ -lgcc_pic\>
endef

define Package/gcc/postrm
	#!/bin/sh
        rm /usr/lib/$(PKG_NAME)/$(REAL_GNU_TARGET_NAME)/$(PKG_VERSION)/specs
endef

$(eval $(call BuildPackage,gcc))
