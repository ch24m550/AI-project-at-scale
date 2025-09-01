# Use JDK 8 base image (Debian slim)
FROM openjdk:8-jdk-slim

# Install Python 3.11 and system dependencies
RUN apt-get update && apt-get install -y \
    python3.11 python3.11-venv python3.11-dev python3-pip \
    curl git build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME explicitly
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Run FastAPI app
CMD ["python3", "-m", "uvicorn", "src.deploy.api:app", "--host", "0.0.0.0", "--port", "9000"]