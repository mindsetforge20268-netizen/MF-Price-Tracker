FROM python:3.11-slim
WORKDIR /app

# Install dependencies first (better for caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the script
COPY . .

# Run the script
CMD ["python", "main.py"]
