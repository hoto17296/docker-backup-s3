FROM python:alpine

# Setup crond
RUN apk --no-cache add tzdata

ADD entrypoint.sh /
ADD crond.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["sh", "/crond.sh"]

# Setup AWS S3 Sync
RUN apk --no-cache add groff \
  && pip install awscli

ADD sync.sh /
ENV SCHEDULED_COMMAND sh /sync.sh