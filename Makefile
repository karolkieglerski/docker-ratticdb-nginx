image := groventure/ratticdb-nginx:1.9

default: build

build: Dockerfile
	docker build --rm -t '$(image)' .
