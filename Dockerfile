FROM python:alpine

RUN apk --no-cache add groff \
  && pip install awscli

ADD entrypoint.sh /
ADD sync.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]
