# Step 1: Use Node.js image
FROM node:18

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Step 4: Copy source code
COPY * .

# Step 5: Build React app
RUN npm run build

# Step 6: Install serve globally
RUN npm install -g serve

# Step 7: Expose port
EXPOSE 3000

# Step 8: Run the app using serve
CMD ["serve", "-s", "build", "-l", "3000"]
