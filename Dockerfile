FROM sdurrheimer/alpine-glibc
MAINTAINER KOJIMA Kazunori kjm.kznr@gmail.com

ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV CGO_ENABLED 0

RUN mkdir -p /go/src/github.com/hashicorp /go/bin && chmod -R 777 /go
RUN apk --update add -t build-deps git bash go bzr git mercurial subversion openssh-client ca-certificates make gcc zip \
     && git clone --branch release/v0.6.6 https://github.com/hashicorp/terraform.git /go/src/github.com/hashicorp/terraform \
     && cd /go/src/github.com/hashicorp/terraform \
     && make updatedeps && make bin \
     && cp bin/terraform* /usr/bin/ \
     && apk del --purge make gcc build-deps \
     && rm -rf /var/cache/apk/* /go/

CMD ["/usr/bin/terraform"]
