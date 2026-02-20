# 1. Use a lightweight base image (Python 3.11 as an example)
FROM python:3.11-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Install system dependencies (e.g., if you need git or specialized tools)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy ONLY the requirements first (optimizes Docker caching)
COPY requirements.txt .

# 5. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of your GitHub repository code into the container
COPY . .

# 7. The command to run your app
CMD ["python", "main.py"]

# The '.' at the end tells Docker to look in the current folder for the Dockerfile
docker build -t mf-price-tracker .

# Run the container
docker run -d --name tracker-instance mf-price-tracker
