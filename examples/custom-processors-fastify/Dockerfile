FROM node:16-alpine3.15

WORKDIR /app

RUN apk update
RUN apk add ca-certificates
RUN update-ca-certificates
RUN apk add dumb-init

COPY --chown=node:node package*.json ./
RUN npm ci --quiet --only=production
COPY --chown=node:node ./routes .
COPY --chown=node:node app.js .
COPY --chown=node:node app.json .
COPY --chown=node:node server.js .
COPY --chown=node:node Procfile .

ENV NODE_PATH=.

USER node
CMD [ "dumb-init", "node", "/app/server.js" ]
