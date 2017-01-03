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
	./node_modules/.bin/gitbook pdf  . ./_book/network-programming-with-go.pdf && \
	./node_modules/.bin/gitbook epub . ./_book/network-programming-with-go.epub && \
	./node_modules/.bin/gitbook mobi . ./_book/network-programming-with-go.mobi && \
	cd _book && \
	git config --global user.name "publisher" && \
	git config --global user.email "publisher@git.hub" && \
	git init && \
	git commit --allow-empty -m 'update gh-pages' && \
	git checkout -b gh-pages && \
	git add . && \
	git commit -am 'update gh-pages' && \
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

