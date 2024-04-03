# Use official node image as the base image
FROM node:14-alpine AS build

# Set the working directory
WORKDIR /var/lib/jenkins/workspace/pfecapgiminipip/

# Add the source code to app
COPY ./ /var/lib/jenkins/workspace/pfecapgiminipip

RUN npm install

# Expose port 8082
EXPOSE 8082
