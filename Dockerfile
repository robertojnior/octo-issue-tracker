FROM ruby:2.7.2

RUN apt-get update && apt-get install -y vim

WORKDIR /usr/app

COPY Gemfile ./

COPY Gemfile.lock ./

RUN bundle install

COPY . .
