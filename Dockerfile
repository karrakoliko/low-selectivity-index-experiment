FROM alpine:latest

RUN apk add --no-cache sqlite

WORKDIR /app

COPY experiment.sh .

RUN chmod +x experiment.sh

CMD ["./experiment.sh"]