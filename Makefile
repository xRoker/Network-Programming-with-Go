SHELL := /bin/bash

.PHONY: all prepare build watch publish pdf clean

all: build

prepare:
	npm run docs:prepare

watch:
	npm run docs:watch

build:
	npm run docs:build

publish: pdf epub mobi
	git config --global user.name "publisher"
	git config --global user.email "publisher@git.hub"
	npm run docs:publish

pdf:
	npm run docs:pdf

epub:
	npm run docs:epub

mobi:
	npm run docs:mobi

clean:
	rm -rf _book
	rm -f *.{pdf,epub,mobi}

