# Etapa de construcción
FROM node:8.17.0 as builder

WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar código fuente
COPY . .

# Construir aplicación
RUN npm run build

# Etapa final
FROM nginx:alpine

# Copiar archivos de construcción a NGINX
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiar configuración personalizada de NGINX si es necesaria
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Variable para configuración en tiempo de ejecución
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082

# Exponer puerto
EXPOSE 8080

# Script para reemplazar variables de entorno en tiempo de ejecución
RUN echo '#!/bin/sh \n\
    sed -i "s|VUE_APP_AUTH_API_ADDRESS|$AUTH_API_ADDRESS|g" /usr/share/nginx/html/js/*.js \n\
    sed -i "s|VUE_APP_TODOS_API_ADDRESS|$TODOS_API_ADDRESS|g" /usr/share/nginx/html/js/*.js \n\
    nginx -g "daemon off;" \n\
    ' > /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]