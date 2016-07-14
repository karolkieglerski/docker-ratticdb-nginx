# kilerkarol/ratticdb-nginx

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
  kilerkarol/ratticdb-nginx:1.9
```
