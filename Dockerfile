# 1. Use a lightweight base image
FROM python:3.11-slim

# 2. Set the working directory
WORKDIR /app

# 3. Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 5. Copy the rest of your GitHub code
COPY . .

# 6. The command to run your app (This should be the LAST line)
CMD ["python", "main.py"]
