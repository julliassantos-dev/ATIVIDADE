CREATE DATABASE LojinhaSQL;
USE LojinhaSQL;

-- 1. Tabela CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    rua VARCHAR(100),
    numero VARCHAR(20),
    cidade VARCHAR(100)
);

-- 2. Tabela FORNECEDOR
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20), 
    email VARCHAR(100),
    rua VARCHAR(100),
    cidade VARCHAR(100),
    cep VARCHAR(10),
    contato VARCHAR(100),
    status ENUM('Ativo', 'Inativo') DEFAULT 'Ativo'

-- 3. Tabela PRODUTO
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50),
    marca VARCHAR(50),
    codigo_barras VARCHAR(50),
    data_validade DATE,
    peso DECIMAL(10, 2),
    status_produto ENUM('Ativo', 'Inativo') DEFAULT 'Ativo', 
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);

-- 4. Tabela ESTOQUE 
CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL UNIQUE,
    quantidade INT NOT NULL DEFAULT 0,
    quantidade_minima INT NOT NULL DEFAULT 0,
    localizacao VARCHAR(50),
    data_entrada DATE,
    data_saida DATE,
    validade DATE,
    lote VARCHAR(50),
    status_estoque ENUM('Disponível', 'Indisponível', 'Esgotado') DEFAULT 'Disponível', 
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- 5. Tabela VENDA
CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    forma_pagamento VARCHAR(50),
    desconto DECIMAL(10, 2) DEFAULT 0.00,
    id_cliente INT NOT NULL,
    status_venda ENUM('Pendente', 'Concluída', 'Cancelada') DEFAULT 'Pendente', 
    hora TIME,
    observacao TEXT,
    caixa VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- 6. Tabela ITEM_VENDA
CREATE TABLE item_venda (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    desconto_item DECIMAL(10, 2) DEFAULT 0.00,
    imposto DECIMAL(10, 2) DEFAULT 0.00,
    status_itemvenda ENUM('Ativo', 'Cancelado') DEFAULT 'Ativo', 
    observacao TEXT,
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- 7. Tabela PAGAMENTO
CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATE NOT NULL,
    status_pagamento ENUM('Pendente', 'Pago', 'Recusado') DEFAULT 'Pendente', 
    parcelas INT DEFAULT 1, 
    bandeira VARCHAR(50),
    autorizacao VARCHAR(50),
    observacao TEXT,
    foreign key(id_venda) references venda(id_venda)
);
