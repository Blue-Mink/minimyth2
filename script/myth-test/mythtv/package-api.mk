MYTHTV_GARVERSION_SHORT = test
MYTHTV_SVN_VERSION = 20190421-g421c0a7
MYTHTV_GIT_VERSION = v31-Pre-666-g421c0a7

MYTHTV_VERSION = $(MYTHTV_GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)

MYTHTV_SOURCEDIR = $(sourcedir)/mythtv

MYTHTV_CONFIGURE_ENV = \
	PYTHONXCPREFIX=$(DESTDIR)$(prefix)
MYTHTV_BUILD_ENV     =
MYTHTV_INSTALL_ENV   = \
	INSTALL_ROOT="/" \

MYTHTV_PLUGINS_CONFIGURE_ARGS = \
	--prefix="$(DESTDIR)$(prefix)" \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--qmake="$(DESTDIR)$(qt5bindir)/qmake" \
	--libdir-name="$(patsubst $(prefix)/%,%,$(libdir))" \
	--disable-all \
	--enable-opengl

post-install-mythtv-version:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "branch $(MYTHTV_GARVERSION_SHORT) through GIT $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
