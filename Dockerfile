FROM nginx:1.9
MAINTAINER Hellyna NG <hellyna@groventure.com>

COPY scripts/* /scripts/
COPY conf/* /usr/local/etc/rattic/
EXPOSE 80/tcp

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
