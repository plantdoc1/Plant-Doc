# Use official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl

# Set work directory
WORKDIR /app

# Copy only requirements first for caching
COPY requirements.txt .

# Install pip and TensorFlow first
RUN pip install --upgrade pip
RUN pip install tensorflow==2.13.0

# Now install the rest of the dependencies
RUN pip install -r requirements.txt

# Copy the rest of the project
COPY . .

# Expose Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
