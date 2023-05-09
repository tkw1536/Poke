FROM docker.io/library/node:20 AS base

# install dependencies
FROM base as build
WORKDIR /app/
ADD . /app/
RUN yarn install --frozen-lockfile

# copy them over to save a single layer!
FROM base
WORKDIR /app/
COPY --from=build /app/ /app/

# listen on port 3000
EXPOSE 3000
USER node
CMD node index.js