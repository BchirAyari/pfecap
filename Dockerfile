# Use official node image as the base image
FROM node:20.12.0-alpine AS build

# Set the working directory
WORKDIR /var/lib/jenkins/workspace/CI_PIPELINE/

# Add the source code to app
COPY ./ /var/lib/jenkins/workspace/CI_PIPELINE

RUN npm install

# Expose port 8082
EXPOSE 8082
