FROM hypriot/rpi-alpine
RUN apk --no-cache add inotify-tools jq openssl util-linux curl
RUN mkdir -p /certs
ENTRYPOINT ["sh"]
