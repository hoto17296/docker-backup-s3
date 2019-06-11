FROM python:alpine

RUN apk --no-cache add groff \
  && pip install awscli

RUN apk --no-cache add tzdata

ADD entrypoint.sh /
ADD sync.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]
