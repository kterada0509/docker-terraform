FROM golang:1.6-alpine
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates &&\
    rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION=0.6.16
ENV TERRAFORM_SHA256SUM=c84bae32a170d993982de9c537eac74f70601e7a667dc2ea9803b86e04b1221d

ENV XC_ARCH=amd64
ENV XC_OS=linux

RUN apk add --no-cache --virtual .builddeps make curl zip &&\
    curl -LO https://github.com/hashicorp/terraform/archive/v${TERRAFORM_VERSION}.tar.gz &&\
    [ "${TERRAFORM_SHA256SUM}" = "$(sha256sum v${TERRAFORM_VERSION}.tar.gz | awk '{print $1}')"  ] &&\
    mkdir -p src/github.com/hashicorp &&\
    tar zxf v${TERRAFORM_VERSION}.tar.gz -C src/github.com/hashicorp &&\
    mv src/github.com/hashicorp/terraform-${TERRAFORM_VERSION} src/github.com/hashicorp/terraform &&\
    cd src/github.com/hashicorp/terraform &&\
    make bin &&\
    rm ../../../../v${TERRAFORM_VERSION}.tar.gz &&\
    apk del .builddeps &&\
    rm -rf /go/src/ /go/bin/gox /go/bin/stringer

CMD ["/go/bin/terraform"]
