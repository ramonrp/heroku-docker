FROM node:16-alpine AS base
RUN mkdir -p /usr/app
WORKDIR  /usr/app

FROM base AS build-front
COPY ./ ./
RUN npm ci
RUN npm run build

FROM build-front AS release
ENV STATIC_FILES_PATH=./public 
COPY --from=build-front /usr/app/dist $STATIC_FILES_PATH
COPY ./server/package.json ./
COPY ./server/package-lock.json ./
COPY ./server/index.js ./


ENTRYPOINT ["node","index"]