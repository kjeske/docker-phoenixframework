FROM ubuntu:latest

MAINTAINER Krzystof Jeske

# SET UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget make git

# install Erlang
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
 && dpkg -i erlang-solutions_1.0_all.deb \
 && apt-get update

# install Elixir
RUN apt-get install -y elixir && rm erlang-solutions_1.0_all.deb

ENV PHOENIX_VERSION 1.1.4

# install Phoenix
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez --force

# install Node.js (>= 5.0.0) and NPM in order to satisfy brunch.io dependencies
# See http://www.phoenixframework.org/docs/installation#section-node-js-5-0-0-
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && apt-get install -y nodejs

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /code
