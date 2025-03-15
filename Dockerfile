FROM node:20-alpine AS git_base

RUN apk add --no-cache git

FROM git_base AS base

WORKDIR /blog

COPY package*.json ./

RUN npm install -g pnpm && pnpm install && pnpm add sharp

FROM base AS builder

WORKDIR /blog

COPY . .

RUN pnpm run build

FROM git_base AS production

ARG TOKEN 
ARG USER
ARG REPO
ARG GIT_DOMAIN
ARG BRANCH

ENV TOKEN=$TOKEN
ENV USER=$USER
ENV REPO=$REPO
ENV GIT_DOMAIN=$GIT_DOMAIN
ENV BRANCH=$BRANCH

WORKDIR /blog

COPY --from=builder /blog/dist /blog

RUN git config --global user.email "deployment@docker.com" && \
    git config --global user.name "Docker Deployment"

RUN git init && git remote add origin https://${USER}:${TOKEN}@${GIT_DOMAIN}/${USER}/${REPO}.git && \
    git switch -c ${BRANCH} && git add . && git commit -m "Deploy by docker" && \
    git push -f origin ${BRANCH}
