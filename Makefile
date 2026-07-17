XCODEBUILD ?= xcodebuild
ARCH ?= $(shell uname -m)
CONFIGURATION ?= Debug
DERIVED_DATA ?= build/DerivedData

.DEFAULT_GOAL := build

.PHONY: bootstrap build clean rebuild

bootstrap:
	git submodule update --init --recursive
	External/objective-git/script/bootstrap

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
