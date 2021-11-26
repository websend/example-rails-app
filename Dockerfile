######################
# Stage: Builder
# We build the application in two stages
# First stage has all build dependencies, second stage only runtime dependencies.
# This results in a smaller image size
FROM ruby:2.7.2-alpine3.12 as builder

# Optional arguments
ARG FOLDERS_TO_REMOVE
ARG BUNDLE_WITHOUT
ARG RAILS_ENV
ARG NODE_ENV

ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV ${RAILS_ENV}
ENV NODE_ENV ${NODE_ENV}
ENV SECRET_KEY_BASE=foo
ENV RAILS_SERVE_STATIC_FILES=true

# Add build packages
RUN apk add --update --no-cache \
    build-base \
    git \
    postgresql-dev \
    nodejs-current \
    yarn \
    tzdata

# Generally we always place the app in the /app folder.
WORKDIR /app

# Install gems
# We only copy the Gemfile and Gemfile.lock. This is to ensure we do not bust the Bundle cache when we change something else in the application.
ADD Gemfile* /app/
RUN gem install bundler:2.1.4
RUN bundle config --global frozen 1 \
 && bundle install -j4 --retry 3 \
 # Remove unneeded files (cached *.gem, *.o, *.c)
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Add the Rails app
ADD . /app

# Remove folders not needed in resulting image
RUN rm -rf $FOLDERS_TO_REMOVE

###############################
# Stage Final
FROM ruby:2.7.2-alpine3.12
LABEL maintainer="development@mobiel.nl"

ARG ADDITIONAL_PACKAGES

# Add runtime packages
RUN apk add --update --no-cache \
    $ADDITIONAL_PACKAGES \
    postgresql-client \
    nodejs-current \
    yarn \
    tzdata \
    file

# Add user so we do not run the application under root
RUN addgroup -g 1000 -S app \
 && adduser -u 1000 -S app -G app

# Copy app with gems from former build stage. We can copy the gems because both these images (build/final) use the same base image.
# We immediately also change the owner to app:app, our new user and group.
COPY --from=builder --chown=app:app /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder --chown=app:app /app /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME Node
ENV TZ Europe/Amsterdam

# Set the default dir as /app
WORKDIR /app

# Precompile all assets
RUN yarn install
RUN RAILS_ENV=${RAILS_ENV} bundle exec rails assets:precompile

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
RUN date -u > /app/BUILD_TIME

# Change the entire /app folder to the app user and group
RUN chown -R app:app /app

# Change the user in the image to app
USER app

# Define the startup command
CMD ["docker/startup.sh"]
