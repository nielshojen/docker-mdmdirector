FROM golang:alpine AS build

# Install tools required for project
RUN apk add --no-cache git
RUN go get github.com/golang/dep/cmd/dep

RUN git clone https://github.com/mdmdirector/mdmdirector.git /go/src/project
WORKDIR /go/src/project/
RUN dep ensure -vendor-only
RUN go build -o /bin/project

FROM alpine
COPY --from=build /bin/project/build/linux/mdmdirector-* /usr/bin/mdmdirector
