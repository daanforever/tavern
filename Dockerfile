FROM ruby:2.1.2
MAINTAINER Alexey Anisimov <aanisimov@at-consulting.ru>

EXPOSE 3000
WORKDIR /usr/src/app

ENV RAILS_ENV production

ADD . /usr/src/app
RUN gem install bundler
RUN bundle install --local --deployment
RUN bundle exec rake db:migrate
RUN bundle exec rake assets:precompile
CMD ["rails", "server"]