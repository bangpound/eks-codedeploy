FROM ruby:2.7.1-alpine3.12

RUN apk add git alpine-sdk wget; \
    git clone https://github.com/aws/aws-codedeploy-agent.git /opt/codedeploy-agent; \
    gem install bundler -v 1.3.5; \
    cd /opt/codedeploy-agent; \
    bundle install

RUN wget --directory-prefix=/tmp/codedeploy \
        https://raw.githubusercontent.com/mumoshu/kodedeploy/master/codedeploy-agent.rb.patch && \
        patch /opt/codedeploy-agent/lib/codedeploy-agent.rb -i /tmp/codedeploy/codedeploy-agent.rb.patch

CMD ["/opt/codedeploy-agent/bin/codedeploy-agent", "start", "--foreground"]
