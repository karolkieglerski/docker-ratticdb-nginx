# groventure/ratticdb-nginx

This repository builds the group of images for
[groventure/ratticdb-nginx](https://hub.docker.com/r/groventure/ratticdb-nginx/).

Available Tags:
+ [latest](https://github.com/groventure/docker-ratticdb-nginx/tree/latest)
+ [1.9](https://github.com/groventure/docker-ratticdb-nginx/tree/1.9)

*This image is not usable alone, and will only work with
[groventure/ratticdb-uwsgi](https://hub.docker.com/r/groventure/ratticdb-uwsgi/).*

## Usage

```shell
docker run \
  --name 'ratticdb-nginx' \
  -p 80 \
  -e 'PROXY_MODE=on' \
  -e 'VIRTUAL_HOST=somedomain.example.com' \
  -e 'CERT_NAME=default' \
  --link 'ratticdb-uwsgi:uwsgi' \
  --volumes-from 'ratticdb-uwsgi' \
  groventure/ratticdb-nginx:1.9
```
