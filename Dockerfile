FROM ruby:2.7.1-alpine3.12

RUN apk add aws-cli jq git alpine-sdk dumb-init; \
    git clone https://github.com/aws/aws-codedeploy-agent.git /opt/codedeploy-agent; \
    gem install bundler -v 1.3.5; \
    cd /opt/codedeploy-agent; \
    bundle install

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["sh", "-c", "/opt/codedeploy-agent/bin/codedeploy-agent start && sleep infinity"]
