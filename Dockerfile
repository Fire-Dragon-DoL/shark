FROM ruby:2.7.1 AS shark

WORKDIR /app

ARG app_env=development
ENV RAILS_ENV=$app_env
ENV PATH="/app/bin:${PATH}"
EXPOSE 3000
ENTRYPOINT ["rails"]
CMD ["s"]

RUN gem update --system=3.1.3
RUN gem install bundler --version 2.1.4

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor vendor
COPY install-gems.sh install-gems.sh
RUN ./install-gems.sh

COPY . .

RUN ./bin/rails log:clear tmp:clear
