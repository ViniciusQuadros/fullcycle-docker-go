# Use a imagem oficial mínima do Golang para compilar
FROM golang:alpine as builder

# Configure o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o código fonte e o arquivo go.mod para o contêiner
COPY main.go go.mod .

# Compile o código Go
RUN go build -o main .

# Use uma imagem mínima do alpine para reduzir o tamanho final da imagem
FROM alpine:latest

# Configure o diretório de trabalho dentro do segundo estágio
WORKDIR /app

# Copie o binário compilado do primeiro estágio
COPY --from=builder /app/main .

# Execute o binário ao iniciar o contêiner
CMD ["./main"]
