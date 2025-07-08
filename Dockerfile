# Use official Python 3.10 image with pip
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker caching
COPY requirements.txt /app/

# Install pip (in case it's not fully set up)
RUN python -m ensurepip && \
    python -m pip install --upgrade pip

# Install TensorFlow before other dependencies
RUN pip install tensorflow==2.18.0

# Install remaining dependencies
RUN pip install -r requirements.txt

# Copy the rest of your app code
COPY . /app

# Expose the default Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
