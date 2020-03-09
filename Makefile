.DEFAULT_GOAL:=help
SHELL := /bin/bash

.PHONY: all install prepare build watch publish pdf epub mobi clean dockbuild dockrun

help:  ## Use `make help` to see this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: install build  ## install all libraries and build the book

install:  ## install gitbook-cli
	npm install 

prepare:  ## run gitbook install command
	npm run gitbook:prepare

build:  ## build the book
	npm run gitbook:build

watch:  ## watch for changes
	npm run gitbook:watch

pdf:  ## generate pdf
	npm run gitbook:pdf

epub: ## generate epub
	npm run gitbook:epub

mobi:  ## generate mobi
	npm run gitbook:mobi

publish: build pdf epub mobi  ## publish gitbook on github pages
	cd _book && \
	git config user.name "publisher" && \
	git config user.email "publisher@git.hub" && \
	git init && \
	git commit --allow-empty -m 'update gh-pages' && \
	git checkout -b gh-pages && \
	git add . && \
	git commit -am 'update gh-pages' && \
	git push https://github.com/tumregels/Network-Programming-with-Go gh-pages --force

clean:  ## remove all libraries and cached files
	rm -rf _book
	rm -rf node_modules
	rm -rf tmp*


dockbuild:  ## build docker image
	docker build -t gitbook .

# use x11 for publishing pdf, epub and mobi ebooks, tested on ubuntu 16.04. \
`make dockrun` will create a container, build the gitbook and attach a terminal, \
to run other commands such as `make watch`, `make publish`.
dockrun:  ## use docker to build gitbook
	docker run -ti --rm -e DISPLAY=${DISPLAY} \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ${HOME}/.Xauthority:/root/.Xauthority \
	-v ${shell pwd}:/app/gitbook \
	--net=host gitbook /bin/bash -c "make build && bash"
