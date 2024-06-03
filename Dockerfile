# Use Node 18 as parent image
FROM node:18 AS build

# Change the working directory on the Docker image to /app
WORKDIR /app

# Copy package.json and package-lock.json to the /app directory
COPY package*.json ./

# Install dependencies
RUN npm install

RUN chmod +x ./node_modules/.bin/ng

# Copy the rest of project files into this image
COPY . .

RUN npm run build

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
