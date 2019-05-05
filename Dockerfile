FROM node:10.13.0-alpine

ARG REACT_ENV=dev
ENV NPM_CONFIG_LOGLEVEL warn

# Install and configure `serve`.
RUN yarn global add serve
CMD serve -s -n -l 3000 build
EXPOSE 3000

# Install all dependencies of the current project.
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install

# Copy all local files into the image.
COPY . .

# Build for given environment
RUN yarn build:${REACT_ENV}