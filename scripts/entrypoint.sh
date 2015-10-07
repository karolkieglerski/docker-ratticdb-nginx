set -e

if [[ -z "$UWSGI_PORT_8000_TCP_ADDR" ]]; then
  echo '$UWSGI_PORT_8000_TCP_ADDR not defined. Aborting...' >&2
  exit 1
fi

if [[ -z "$UWSGI_PORT_8000_TCP_PORT" ]]; then
  echo '$UWSGI_PORT_8000_TCP_PORT not defined. Aborting...' >&2
  exit 1
fi

nginx_conf_path='/etc/nginx/conf.d/rattic.conf'

cat > "$nginx_conf_path" <<EOF
upstream rattic {
  server ${UWSGI_PORT_8000_TCP_ADDR}:${UWSGI_PORT_8000_TCP_PORT};
}

server {
  listen 80 default_server;
  server_name _;
  client_max_body_size 5M;
EOF

if [[ "$PROXY_MODE" == 'true' || "$PROXY_MODE" == 'on' || "$PROXY_MODE" == 1 ]]; then
  cat >> "$nginx_conf_path" <<EOF
  real_ip_header X-Forwarded-For;
  real_ip_recursive on;
  set_real_ip_from 172.17.0.0/16;
EOF
fi

cat >> "$nginx_conf_path" <<EOF
  location /static {
    alias /srv/rattic/static;
  }
  location / {
    uwsgi_pass  rattic;
    uwsgi_param QUERY_STRING    \$query_string;
    uwsgi_param REQUEST_METHOD  \$request_method;
    uwsgi_param CONTENT_TYPE    \$content_type;
    uwsgi_param CONTENT_LENGTH  \$content_length;

    uwsgi_param REQUEST_URI     \$request_uri;
    uwsgi_param PATH_INFO       \$document_uri;
    uwsgi_param DOCUMENT_ROOT   \$document_root;
    uwsgi_param SERVER_PROTOCOL \$server_protocol;
    uwsgi_param HTTPS           \$https if_not_empty;

    uwsgi_param REMOTE_ADDR     \$remote_addr;
    uwsgi_param REMOTE_PORT     \$remote_port;
    uwsgi_param SERVER_PORT     \$server_port;
    uwsgi_param SERVER_NAME     \$server_name;
  }
  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;
}
EOF

rm -f /etc/nginx/conf.d/default.conf
exec /usr/sbin/nginx -g 'daemon off;'

set +e
