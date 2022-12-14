# gets the docker image of ruby 2.5 and lets us build on top of that
FROM ruby:3.1.2-slim

# install ruby dependencies
RUN apt-get update -qq && apt-get install -y build-essential

# create a folder /myapp in the docker container and go into that folder
RUN mkdir /myapp
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN bundle install

# Copy the whole app
COPY . /myapp
