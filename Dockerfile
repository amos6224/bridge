FROM debian:jessie

MAINTAINER 'jeff@namely.com'

#Refresh the repo based on date to expedite the build.
ENV REFRESHED_AT 06-05-2015

#Install ruby and its dependencies
RUN apt-get update -qq && apt-get install -y ruby ruby-dev build-essential redis-tools
RUN apt-get install -y libxml2 zlib1g zlib1g-dev libpq-dev libsqlite3-dev  
RUN gem install --no-rdoc --no-ri sinatra json redis bundler

RUN mkdir -p /opt/webapp
WORKDIR /opt/webapp
COPY Gemfile /opt/webapp/
COPY Gemfile.lock /opt/webapp/

ADD . /opt/webapp

#http://stackoverflow.com/questions/29421099/sinatra-error-unable-to-activate-sinatra-contrib-1-4-2 
RUN bundle
RUN gem uninstall tilt -v 2.0.1

RUN bundle install

EXPOSE 4567
CMD ["/opt/webapp/bin/admin_interface"]
