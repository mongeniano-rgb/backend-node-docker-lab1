FROM node:22.18 AS inicial

WORKDIR /usr/app

COPY ./ ./

RUN npm install

RUN npm run build

FROM node:22-alpine AS produccion

WORKDIR /usr/app

COPY --from=inicial /usr/app/dist ./dist
COPY --from=inicial /usr/app/package*.json .

RUN npm install --only=production

EXPOSE 4000

CMD ["node", "dist/main.js"]