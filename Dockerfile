# 1. Usar uma imagem oficial do Python como imagem base
# Usar a tag -slim é um bom equilíbrio entre tamanho e ter as ferramentas necessárias.
# O readme menciona Python 3.10+, então 3.11 é uma ótima escolha.
FROM python:3.11-slim

# 2. Definir o diretório de trabalho no contêiner
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache do Docker
# Isso evita a reinstalação das dependências a cada mudança no código.
COPY requirements.txt .

# 4. Instalar os pacotes necessários especificados no requirements.txt
# A flag --no-cache-dir mantém o tamanho da imagem menor
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação
COPY . .

# 6. Expor a porta em que a aplicação será executada
EXPOSE 8000

# 7. Definir o comando para executar a aplicação
# Use 0.0.0.0 para torná-la acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]