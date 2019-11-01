FROM ruby:2.6

RUN mkdir /app
WORKDIR /app
RUN gem install bundler

ADD Gemfile* /app/
RUN bundle install

ADD . /app


ENTRYPOINT [ "/usr/local/bin/ruby", "/app/app.rb" ]
