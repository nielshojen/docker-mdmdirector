FROM golang:alpine AS build

RUN apk add --no-cache git
RUN git clone https://github.com/mdmdirector/mdmdirector.git /go/src/project
WORKDIR /go/src/project/
RUN go build
RUN ls -lR /go/src/project/build/

FROM alpine
COPY --from=build /bin/project/build/linux/mdmdirector-* /usr/local/bin/mdmdirector
RUN mkdir /certs
COPY run.sh /run.sh
RUN chmod a+x /run.sh
VOLUME ["/certs"]
CMD ["/run.sh"]
