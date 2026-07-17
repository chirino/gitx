XCODEBUILD ?= xcodebuild
BREW ?= brew
ARCH ?= $(shell uname -m)
CONFIGURATION ?= Debug
DERIVED_DATA ?= build/DerivedData

.DEFAULT_GOAL := build

.PHONY: bootstrap build clean rebuild

bootstrap:
	git submodule update --init --recursive
	cp -f "$$($(BREW) --prefix libssh2)/lib/libssh2.a" External/objective-git/External/libssh2.a
	cp -f "$$($(BREW) --prefix openssl)/lib/libcrypto.a" External/objective-git/External/libcrypto.a

build: bootstrap
	$(XCODEBUILD) \
		-workspace GitX.xcworkspace \
		-scheme GitX \
		-configuration $(CONFIGURATION) \
		-destination 'platform=macOS,arch=$(ARCH)' \
		-derivedDataPath $(DERIVED_DATA) \
		build

clean:
	$(XCODEBUILD) \
		-workspace GitX.xcworkspace \
		-scheme GitX \
		-configuration $(CONFIGURATION) \
		-destination 'platform=macOS,arch=$(ARCH)' \
		-derivedDataPath $(DERIVED_DATA) \
		clean

rebuild: clean build
