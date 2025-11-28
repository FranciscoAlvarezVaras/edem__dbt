FROM python:3.12-slim

# Donde uv va a crear el entorno del proyecto (fuera del código)
ENV UV_PROJECT_ENVIRONMENT=/opt/venv \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Paquetes básicos del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    bash \
    git \
 && rm -rf /var/lib/apt/lists/*

# Instalar uv (gestor de paquetes)
RUN pip install --no-cache-dir uv

# Instalar DuckDB CLI con el script oficial
# (descarga el binario y lo deja en ~/.duckdb/cli/latest/duckdb)
RUN curl https://install.duckdb.org | sh \
 && ln -s /root/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Por defecto entramos a un shell
CMD ["bash"]
