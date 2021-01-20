FROM alpine

ENV MDMDIRECTOR_VERSION="0.0.10"

RUN apk --update add curl ca-certificates
RUN /usr/bin/curl -L https://github.com/mdmdirector/mdmdirector/releases/download/${MDMDIRECTOR_VERSION}/mdmdirector-linux -o /usr/local/bin/mdmdirector
RUN chmod +x /usr/local/bin/mdmdirector

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8000

CMD ["/run.sh"]
