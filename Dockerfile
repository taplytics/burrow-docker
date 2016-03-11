FROM golang

MAINTAINER Alex Nederlof "https://github.com/alexnederlof"

RUN mkdir -p /opt/burrow/log && \
    useradd --system --home /opt/burrow burrow && \
    chown -R burrow /opt/burrow 

RUN go get github.com/linkedin/burrow
RUN wget https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm && chmod +x gpm && mv gpm /usr/local/bin
RUN cd $GOPATH/src/github.com/linkedin/burrow && gpm install && go install

USER burrow

ADD config /etc/burrow

CMD ["/go/bin/burrow", "--config", "/etc/burrow/burrow.cfg"]
