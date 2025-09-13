# Use Ruby 3.2 slim image for smaller size
FROM ruby:3.2-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy Gemfile and install Ruby dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copy application code
COPY . .

# Create non-root user for security
RUN useradd --create-home --shell /bin/bash bifronst
RUN chown -R bifronst:bifronst /app
USER bifronst

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Start the application
CMD ["bundle", "exec", "ruby", "server.rb"]
