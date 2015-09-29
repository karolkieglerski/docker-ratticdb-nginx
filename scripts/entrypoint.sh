set -e

if [[ -z "$UWSGI_PORT_8000_TCP_ADDR" ]]; then
  echo '$UWSGI_PORT_8000_TCP_ADDR not defined. Aborting...' >&2
  exit 1
fi

if [[ -z "$UWSGI_PORT_8000_TCP_PORT" ]]; then
  echo '$UWSGI_PORT_8000_TCP_PORT not defined. Aborting...' >&2
  exit 1
fi

nginx_conftmpl_path='/usr/local/etc/rattic/nginx.tmpl.conf'
nginx_conf_path='/etc/nginx/conf.d/rattic.conf'

install -Zm 0600 "$nginx_conftmpl_path" "$nginx_conf_path"
sed -ir \
  's/{{\s*uwsgi_host\s*}}/'"$UWSGI_PORT_8000_TCP_ADDR"'/g' \
  "$nginx_conf_path"

sed -ir \
  's/{{\s*uwsgi_port\s*}}/'"$UWSGI_PORT_8000_TCP_PORT"'/g' \
  "$nginx_conf_path"

rm -f /etc/nginx/conf.d/default.conf "${nginx_conf_path}r"
exec /usr/sbin/nginx -g 'daemon off;'

set +e
