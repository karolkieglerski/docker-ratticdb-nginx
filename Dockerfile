FROM nginx:1.9
MAINTAINER Hellyna NG <hellyna@groventure.com>

COPY scripts/* /scripts/
COPY conf/* /usr/local/etc/rattic/

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
