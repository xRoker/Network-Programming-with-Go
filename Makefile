SHELL := /bin/bash

.PHONY: all install prepare build watch publish pdf epub mobi clean

all: install build

install: # install gitbook-cli
	npm install 

prepare:
	npm run gitbook:prepare

build:
	npm run gitbook:build

watch:
	npm run gitbook:watch

publish:
	npm run gitbook:build && \
	gitbook pdf  . ./_book/network-programming-with-go.pdf && \
	gitbook epub . ./_book/network-programming-with-go.epub && \
	gitbook mobi . ./_book/network-programming-with-go.mobi && \
	cd _book && \
	git config --global user.name "publisher" && \
	git config --global user.email "publisher@git.hub" && \
	git init && \
	git commit --allow-empty -m 'Update gh-pages' && \
	git checkout -b gh-pages && \
	git add . && \
	git commit -am 'Update gh-pages' && \
	git push https://github.com/tumregels/Network-Programming-with-Go gh-pages --force

pdf:
	npm run gitbook:pdf

epub:
	npm run gitbook:epub

mobi:
	npm run gitbook:mobi

clean:
	rm -rf _book
	rm -f *.{pdf,epub,mobi}

