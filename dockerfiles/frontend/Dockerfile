# # Step 1: Use Node.js image
# FROM node:18

# # Step 2: Set working directory
# WORKDIR /app

# # Step 3: Copy package.json and install dependencies
# COPY package*.json ./
# RUN npm install

# # Step 4: Copy source code
# COPY . .

# # Step 5: Build React app
# RUN npm run build

# # Step 6: Install serve globally
# RUN npm install -g serve

# # Step 7: Expose port
# EXPOSE 3000

# # Step 8: Run the app using serve
# CMD ["serve", "-s", "build", "-l", "3000"]

# Stage 1: Build React app using Node

FROM node:18 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve app using Nginx
FROM nginx:stable-alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for nginx
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
