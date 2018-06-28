FROM docker:latest
ENV         GOPATH /go
ENV         SRCPATH ${GOPATH}/src/github.com/adnanh
ENV         WEBHOOK_VERSION 2.4.0
ENV         JQ_VERSION 1.5
ENV         VDOCKER_VERSION 0.0.5

RUN         apk add --update -t build-deps curl git go libc-dev gcc libgcc && \
            apk add --update bash tar xz bzip2 && \
            curl -L -o /tmp/webhook-${WEBHOOK_VERSION}.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
            mkdir -p ${SRCPATH} && tar -xvzf /tmp/webhook-${WEBHOOK_VERSION}.tar.gz -C ${SRCPATH} && \
            mv -f ${SRCPATH}/webhook-* ${SRCPATH}/webhook && \
            cd ${SRCPATH}/webhook && go get -d && go build -o /usr/local/bin/webhook && \
            curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 && \
            chmod a+x /usr/bin/jq && \
            curl -L -o /usr/bin/vdocker https://github.com/wpalmer/vdocker/releases/download/v${VDOCKER_VERSION}/vdocker.sh && \
            chmod a+x /usr/bin/vdocker && \
            apk del --purge build-deps && \
            rm -rf /var/cache/apk/* && \
            rm -rf ${GOPATH}

EXPOSE      9000

ENTRYPOINT  ["/usr/local/bin/webhook"]
