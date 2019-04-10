FROM node:10 AS node-build

RUN yarn global add ember-cli@3.8.1

RUN mkdir -p /app/dist

RUN groupadd -r user \
  && useradd --create-home -g user -G audio,video user \
  && chown -R user:user /app

USER user

WORKDIR /app

# Copy over package manifests first, so that other source code changes don't cause packages to be
# re-restored. If a new dependency is added, the container needs to be re-built.
COPY --chown=user:user ./package.json .
COPY --chown=user:user ./yarn.lock .

RUN yarn

# Copy over the rest of the source.
COPY --chown=user:user . .

# Do an initial build for the CDN
ARG SKIP_FIRST_BUILD
RUN if [ ! "$SKIP_FIRST_BUILD" ]; then \
    ember build; \
  fi

CMD ["ember", "serve3"]
