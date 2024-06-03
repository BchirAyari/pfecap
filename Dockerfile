# Use official node image as the base image
FROM node:alpine

# Set the working directory
WORKDIR /var/lib/jenkins/workspace/CI_PIPELINE/

# Add the source code to app
COPY . /var/lib/jenkins/workspace/CI_PIPELINE/dist/capgimini

RUN npm install -g @angular/cli

RUN npm install

CMD ["ng", "serve", "--host", "0.0.0.0"]

# Expose port 4200
EXPOSE 4200
