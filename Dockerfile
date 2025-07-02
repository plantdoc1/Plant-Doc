# Use official slim Python 3.10 image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev \
    libbz2-dev \
    liblzma-dev \
    libreadline-dev \
    libsqlite3-dev \
    zlib1g-dev \
    libncursesw5-dev \
    libgdbm-dev \
    libnss3-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    libdb-dev \
    git && \
    apt-get clean

# Set working directory
WORKDIR /app

# Copy requirements and upgrade pip, install TensorFlow first
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install tensorflow==2.18.0 && \
    pip install -r requirements.txt

# Copy the rest of the app
COPY . /app

# Expose port for Flask
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
