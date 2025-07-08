# Use official slim Python 3.10 image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    wget \
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
    libdb-dev \
    git && \
    apt-get clean

# Install pip manually
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

# Set working directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir tensorflow==2.18.0 && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app

# Expose Flask default port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
