FROM python:3.6-alpine

WORKDIR /app

# Copiar requisitos
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código fuente
COPY main.py .

# Variables de entorno por defecto
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Ejecutar la aplicación
CMD ["python", "main.py"]