# Base Image
FROM postgres:13

# Set environment variables
ENV POSTGRES_USER=expense
ENV POSTGRES_PASSWORD=Admin@123
ENV POSTGRES_DB=expensetracker

# Copy custom init script into container
COPY permissions.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL Port
EXPOSE 5432
