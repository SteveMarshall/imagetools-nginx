NGINX_FULL_VERSION  = 1.6.0-1~precise
NGINX_CUSTOM_VERSION = $(NGINX_FULL_VERSION)+tizaro
NGINX_VERSION       = 1.6.0
SMALL_LIGHT_VERSION = 0.5.2
NGINX_SRC           = build/nginx-$(NGINX_VERSION)
MODULES_DIR         = $(NGINX_SRC)/debian/modules
SMALL_LIGHT_SRC     = $(MODULES_DIR)/ngx_small_light-$(SMALL_LIGHT_VERSION)

all: build/nginx_$(NGINX_CUSTOM_VERSION)_amd64.deb

nginx-src: $(NGINX_SRC)

small-light-src: $(SMALL_LIGHT_SRC)

build/nginx_$(NGINX_CUSTOM_VERSION)_amd64.deb: $(NGINX_SRC)/debian/rules $(NGINX_SRC)/debian/changelog $(SMALL_LIGHT_SRC)/config
	cd $(NGINX_SRC) && dpkg-buildpackage -b

$(NGINX_SRC)/debian/rules: debian_rules.patch $(NGINX_SRC)
	patch -p0 $(NGINX_SRC)/debian/rules < debian_rules.patch

$(NGINX_SRC)/debian/changelog: debian_changelog.patch $(NGINX_SRC)
	patch -p0 $(NGINX_SRC)/debian/changelog < debian_changelog.patch

$(NGINX_SRC):
	cd build \
	&& apt-get source nginx

$(MODULES_DIR): $(NGINX_SRC)
	mkdir -p $(MODULES_DIR)

$(SMALL_LIGHT_SRC)/config: $(SMALL_LIGHT_SRC)
	cd $(SMALL_LIGHT_SRC) && ./setup

$(SMALL_LIGHT_SRC): $(MODULES_DIR)
	cd $(MODULES_DIR) \
	&& wget https://github.com/cubicdaiya/ngx_small_light/archive/v$(SMALL_LIGHT_VERSION).tar.gz \
	&& tar xvzf v$(SMALL_LIGHT_VERSION).tar.gz

install: build/nginx_$(NGINX_CUSTOM_VERSION)_amd64.deb
	dpkg -i build/nginx_$(NGINX_CUSTOM_VERSION)_amd64.deb

clean:
	@rm -rf build/*
