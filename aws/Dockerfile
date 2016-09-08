FROM almir/webhook

ENV JQ_VERSION 1.5
RUN apk add --update bash curl py-pip \
 && pip install --upgrade pip \
 && pip install awscli aws-shell \
 && curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 \
 && chmod a+x /usr/bin/jq
