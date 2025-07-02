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
    git

# Upgrade pip
RUN pip install --upgrade pip

# Install TensorFlow BEFORE requirements.txt
RUN pip install tensorflow==2.13.0

# Set working directory
WORKDIR /app

# Copy and install app dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy all other project files
COPY . /app

# Expose port (default Flask)
EXPOSE 5000

# Start the app
CMD ["python", "app.py"]
