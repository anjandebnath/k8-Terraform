#Script for building a single image.

# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --only=production


# Copy the rest of the project files
COPY . .

# Expose the port the app runs on
#EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]