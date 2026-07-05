DROP DATABASE IF EXISTS FarmaciaDB;
CREATE DATABASE FarmaciaDB;
USE FarmaciaDB;

-- 1 cliente
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL
);

-- 2 remedio
CREATE TABLE remedio (
    id_remedio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    bula TEXT,
    valor_venda DECIMAL(10 , 2 ) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0
);

-- 3 fornecedor
CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    quantidade INT DEFAULT 0
);

-- 4 venda
CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_compra DATE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- 5 item_venda
CREATE TABLE item_venda (
    id_venda INT NOT NULL,
    id_remedio INT NOT NULL,
    quantidade_vendida INT NOT NULL,
    requer_receita ENUM('sim', 'não'),
    PRIMARY KEY (id_venda , id_remedio),
    FOREIGN KEY (id_venda) REFERENCES venda (id_venda),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio)
);

-- 6 remedio fornecedor
CREATE TABLE remedio_fornecedor (
    id_remedio INT NOT NULL,
    id_fornecedor INT NOT NULL,
    preco DECIMAL(10 , 2 ) NOT NULL,
    PRIMARY KEY (id_remedio , id_fornecedor),
    FOREIGN KEY (id_remedio) REFERENCES remedio (id_remedio),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
);


-- =================================================================
-- INSERTS 

INSERT INTO cliente (cpf, nome) VALUES 
('123.456.789-00', 'João Silva'),
('987.654.321-11', 'Maria Oliveira');

INSERT INTO remedio (nome, descricao, bula, valor_venda, quantidade_estoque) VALUES 
('Dipirona Monoidratada 500mg', 'Analgésico e antitérmico.', 'Indicações: dor e febre...', 8.50, 200),
('Cloridrato de Amoxicilina 500mg', 'Antibiótico bactericida.', 'Uso restrito e venda sob receita...', 38.90, 50);

INSERT INTO fornecedor (cnpj, nome, quantidade) VALUES 
('11.222.333/0001-44', 'MedDistribuidora S.A.', 12),
('55.666.777/0001-88', 'FarmaAtacado Sul', 30);

INSERT INTO remedio_fornecedor (id_remedio, id_fornecedor, preco) VALUES 
(1, 1, 3.10), -- Dipirona na MedDistribuidora
(1, 2, 2.95), -- Dipirona no FarmaAtacado
(2, 1, 18.50); -- Amoxicilina na MedDistribuidora

INSERT INTO venda (data_compra, id_cliente) VALUES 
('2026-06-20', 1), -- Venda para o João
('2026-06-21', 2); -- Venda para a Maria


INSERT INTO item_venda (id_venda, id_remedio, quantidade_vendida, requer_receita) VALUES 
(1, 1, 3, 'não'), -- João levou 3 Dipironas (não precisa de receita)
(2, 1, 1, 'não'), -- Maria levou 1 Dipirona
(2, 2, 1, 'sim');  -- Maria levou 1 Amoxicilina (precisa de receita)
