FROM rails:4.1.6
MAINTAINER Alexey Anisimov <aanisimov@at-consulting.ru>

EXPOSE 3000
WORKDIR /usr/src/app

ENV RAILS_ENV production

ADD . /usr/src/app
RUN bundle install --local --deployment --without=development,test
RUN echo "  secret_key_base: $(bundle exec rake secret)" >> config/secrets.yml

CMD ["foreman", "start"]

