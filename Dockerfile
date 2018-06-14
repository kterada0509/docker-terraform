FROM alpine
LABEL maintainer="KOJIMA Kazunori kjm.kznr@gmail.com"

ENV TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_PROVIDER_MACKEREL_VERSION=0.1.0
ENV TERRAFORM_PROVIDER_ELASTICSEARCH_VERSION=0.0.5

RUN apk --update add git bash bzr git mercurial subversion openssh-client ca-certificates curl
RUN curl -LOs https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin/
RUN rm -rf /var/cache/apk/* terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN curl -LOs https://github.com/kjmkznr/terraform-provider-mackerel/releases/download/v${TERRAFORM_PROVIDER_MACKEREL_VERSION}/linux_amd64.zip
RUN unzip linux_amd64.zip -d /usr/bin/
RUN rm -rf linux_amd64.zip

RUN curl -LOs https://github.com/kjmkznr/terraform-provider-elasticsearch/releases/download/v${TERRAFORM_PROVIDER_ELASTICSEARCH_VERSION}/linux_amd64.zip
RUN unzip linux_amd64.zip -d /usr/bin/
RUN rm -rf linux_amd64.zip

CMD ["/usr/bin/terraform"]
