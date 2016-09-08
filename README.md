Webhook, Dockerized, with Docker, for ad-hoc Docker Image builds
=================

A combination of the official [`docker`](https://hub.docker.com/_/docker/) image,
the [`webhook`](https://hub.docker.com/r/almir/webhook/) image,
and the [`vdocker`](https://github.com/wpalmer/vdocker/) script.

This should be all you need to piece together a basic ad-hoc build system.

The `aws` tag is a combination of the
[`webhook`](https://hub.docker.com/r/almir/webhook/) and the
[`aws`](https://github.com/wpalmer/aws/) command-line interface, without docker,
for when all you need is to trigger an AWS API call (such as an SNS
notification, or a CloudFormation stack update) via a webhook.

Example:

invocation
```bash
docker run \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $PWD/webhook:/etc/webhook \
    -v $PWD/git:/git-cache \
    -v $PWD/id_rsa:/id_rsa \
    -d wpalmer/webhook:docker \
    -verbose -hooks=/etc/webhook/hooks.json -hotreload
```

example hook script
```bash
#!/bin/sh
GIT_URL="$1"
GIT_REF="$2"
GIT_COMMIT="$3"
GIT_DIR=/git-cache
GIT_SSH_COMMAND='ssh -i /id_rsa'
BUILD_DIR=/build-$GIT_COMMIT

export GIT_DIR GIT_SSH_COMMAND
mkdir -p $BUILD_DIR &&
git init &&
git fetch "$GIT_URL" "$GIT_REF" &&
git archive "$GIT_COMMIT:" | tar -x -C $BUILD_DIR &&
docker build $BUILD_DIR
rm -rf "$BUILD_DIR"
```
