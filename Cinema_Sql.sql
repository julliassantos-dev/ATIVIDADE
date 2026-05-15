CREATE DATABASE cinema;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11),
    nome VARCHAR(100),
    rg INT,
    data_nascimento DATE
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    valor_pedido DECIMAL(10 , 2 ),
    id_cliente INT,
    data_pedido DATE,
    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id_cliente)
);

CREATE TABLE filme (
    id_filme INT PRIMARY KEY AUTO_INCREMENT,
    categoria_filme VARCHAR(100),
    classificacao_filme INT,
    duracao_filme INT
    
);

CREATE TABLE sala (
    id_sala INT PRIMARY KEY AUTO_INCREMENT,
    numero_sala INT,
    id_sessao INT,
    tipo_sala VARCHAR(45)
);

CREATE TABLE sessoes (
    id_sessao INT PRIMARY KEY AUTO_INCREMENT,
    horario_sessao DATETIME,
    id_pedido INT NOT NULL,
    id_sala INT NOT NULL,
    id_filme INT NOT NULL,
    FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido)
);

CREATE TABLE tipo_ingresso (
    id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    descricao_tipo VARCHAR(200),
    valor_tipo DECIMAL(10 , 2 )
);

CREATE TABLE ingresso (
    id_ingresso INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_sessao INT NOT NULL,
    valor_ingresso DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (id_pedido)
        REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_sessao)
        REFERENCES sessoes (id_sessao)
);

