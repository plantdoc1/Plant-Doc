# Use official Python 3.10 image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system packages and Python build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-pip \
    python3-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip safely
RUN python3 -m pip install --upgrade pip

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt /app/
RUN pip install tensorflow==2.18.0
RUN pip install -r requirements.txt

# Copy the rest of your app
COPY . /app

# Expose Flask default port
EXPOSE 5000

# Start the Flask app
CMD ["python", "app.py"]
