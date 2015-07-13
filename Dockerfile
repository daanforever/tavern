FROM rails:4.2

EXPOSE 3000 3001 3002 3003

ENV RAILS_ENV production
ENV APP_HOME /myapp
ENV PATH /usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR $APP_HOME
VOLUME [$APP_HOME]
CMD bin/foreman start

RUN apt-get update -qq && apt-get install -y build-essential libxml2-dev libxslt1-dev bash procps

RUN rm -rf $APP_HOME; mkdir -p $APP_HOME
ADD app/Gemfile* $APP_HOME/
ADD cache $APP_HOME/vendor/cache
RUN bundle install --local --deployment --without=development,test

ADD app $APP_HOME
RUN echo "  secret_key_base: $(bundle exec rake secret)" >> config/secrets.yml;

