build:
	cd ./overlay && \
	bash ./build/build.sh Lenovo/J716F
	cp ./overlay/build/treble-overlay-lenovo-J716F.apk ./system/product/overlay/
pack:
	# Create dist dir if not exists
	if [ ! -d dist ]; then mkdir dist; fi
	zip -r -9 -q dist/lenovo-j716f-gsi-fix-$(ver).zip \
		changelog.md \
		common \
		customize.sh \
		LICENSE \
		META-INF \
		module.prop \
		README.md \
		system \
		uninstall.sh \
		update.json
	@echo "Done! Please checkout dist/lenovo-j716f-gsi-fix-$(ver).zip"

clean:
	rm -rf dist
	rm -rf overlay/build/treble-overlay-lenovo-J716F.apk

.PHONY: build pack clean
