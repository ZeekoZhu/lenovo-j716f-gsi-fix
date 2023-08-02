build:
	cd ./overlay && \
	bash ./build/build.sh Lenovo/J716F
	cp ./overlay/build/treble-overlay-lenovo-J716F.apk ./system/product/overlay/
pack:
	# Create dist dir if not exists
	if [ ! -d dist ]; then mkdir dist; fi
	# Get version code, it should be read from module.prop
	ver_code=$(shell grep -E '^versionCode=' module.prop | cut -d '=' -f 2) \
	inc=1 \
	next_ver_code=$$((ver_code + inc)) \
	# replace <version> in module.prop.tpl \
	# replace <versionCode> in module.prop.tpl \
	sed -e "s/<version>/$$ver/g" \
		-e "s/<versionCode>/$$next_ver_code/g" \
		module.prop.tpl > module.prop && \
	# replace <version> in update.json \
	# replace <versionCode> in module.prop.tpl \
	sed -e "s/<version>/$$ver/g" \
		-e "s/<versionCode>/$$next_ver_code/g" \
		update.json.tpl > update.json
	
	zip -r -9 -q dist/lenovo-j716f-gsi-fix-$(ver).zip \
		common \
		customize.sh \
		META-INF \
		module.prop \
		system \
		uninstall.sh
	@echo "Done! Please checkout dist/lenovo-j716f-gsi-fix-$(ver).zip"

clean:
	rm -rf dist
	rm -rf overlay/build/treble-overlay-lenovo-J716F.apk

.PHONY: build pack clean
