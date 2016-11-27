SHELL := /bin/bash

.PHONY: all prepare build watch publish pdf clean

all: build

prepare:
	npm run docs:watch

watch:
	npm run docs:watch

build:
	npm run docs:build

publish:
	npm run docs:publish

pdf:
	npm run docs:pdf

epub:
	npm run docs:epub

mobi:
	npm run docs:mobi

clean:
	rm -rf _book
	rm -rf node_modules
	rm *.{pdf,epub,mobi}

