FROM node:16-alpine
RUN mkdir -p /usr/app
WORKDIR  /usr/app

COPY ./ ./
RUN npm ci
RUN npm run build

RUN cp -r ./dist ./server/public
RUN cd server
RUN npm ci

ENTRYPOINT ["node","server"]