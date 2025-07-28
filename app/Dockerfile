# Use a specific, non-latest tag for better security and reproducibility
FROM python:3.9-slim

WORKDIR /app

# ADD THIS LINE: Upgrade core packaging tools first
RUN python -m pip install --upgrade pip setuptools

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Set an environment variable for the API key, which will be
# overridden by the Kubernetes secret.
ENV API_KEY="not-set"

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["python", "main.py"]