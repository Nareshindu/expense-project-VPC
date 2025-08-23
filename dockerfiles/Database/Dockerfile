# Base image
FROM postgres:13

# Set default postgres user (admin)
ENV POSTGRES_USER=expense
ENV POSTGRES_PASSWORD=Admin@123
ENV POSTGRES_DB=postgres

# Copy init SQL
COPY permissions.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432
