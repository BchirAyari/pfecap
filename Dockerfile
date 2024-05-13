# Use official node image as the base image
FROM node:18

# Set the working directory
WORKDIR /var/lib/jenkins/workspace/CI_PIPELINE/

# Add the source code to app
COPY ./ /var/lib/jenkins/workspace/CI_PIPELINE

RUN npm install

# Expose port 8082
EXPOSE 8082
