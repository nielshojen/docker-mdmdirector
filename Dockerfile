FROM golang:latest as builder

WORKDIR /go/src/github.com/mdmdirector/mdmdirector/

ENV CGO_ENABLED=0 \
    GOARCH=amd64 \
    GOOS=linux

COPY . .

RUN make deps
RUN make


FROM alpine

RUN apk --update add ca-certificates

COPY --from=builder /go/src/github.com/mdmdirector/mdmdirector/build/linux/mdmdirector /usr/local/bin/mdmdirector
RUN chmod +x /usr/local/bin/mdmdirector

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8000

CMD ["/run.sh"]
