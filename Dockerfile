FROM alpine

ENV MDMDIRECTOR_VERSION="0.0.7"

RUN apk --update add curl ca-certificates
RUN /usr/bin/curl https://github.com/mdmdirector/mdmdirector/releases/download/v${MDMDIRECTOR_VERSION}/mdmdirector-linux -o /usr/local/bin/mdmdirector
RUN mkdir /certs

COPY run.sh /run.sh
RUN chmod a+x /run.sh

VOLUME ["/certs"]

EXPOSE 8000

CMD ["/run.sh"]
