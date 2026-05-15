
DROP DATABASE loja_eletronicos;

create database loja_eletronicos;
USE loja_eletronicos;
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2),
    categoria VARCHAR(50),
    marca VARCHAR(50)
);

CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    quantidade INT,

    FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto)
);

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_venda DATE,
    valor_total DECIMAL(10,2),

    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
);

CREATE TABLE item_venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),

    FOREIGN KEY (id_venda)
    REFERENCES venda(id_venda),

    FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto)
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT,
    tipo_pagamento VARCHAR(30),
    valor DECIMAL(10,2),

    FOREIGN KEY (id_venda)
    REFERENCES venda(id_venda)
);