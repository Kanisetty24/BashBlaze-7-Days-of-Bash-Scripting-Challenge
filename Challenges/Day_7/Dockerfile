# Base image
FROM python:3.9-slim

# Set working directory within the container
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the Flask application code to the container
COPY . .

# Expose port 5000 (Flask default)
EXPOSE 5000

# Command to run the Flask application
CMD ["python", "app.py"]
