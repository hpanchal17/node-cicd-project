#stage 1
FROM node:18-alpine AS nodeimg
WORKDIR /apps
COPY package.json package-lock.json ./
RUN npm install

#stage 2
FROM node:18-alpine
WORKDIR /app
COPY --from=nodeimg /app .
COPY . .
CMD ["node", "index.js"]
