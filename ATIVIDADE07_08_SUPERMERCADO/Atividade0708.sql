CREATE DATABASE IF NOT EXISTS SupermercadoDB;
USE SupermercadoDB;

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    contato VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE Filiais (
    id_filial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15) UNIQUE,
    endereco VARCHAR(200),
    pontos_fidelidade INT DEFAULT 0
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE EstoqueFilial (
    id_produto INT NOT NULL,
    id_filial INT NOT NULL,
    quantidade_estoque INT NOT NULL,
    PRIMARY KEY (id_produto, id_filial),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE Funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    data_contratacao DATE NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE Compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_fornecedor INT NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
    FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE ItensCompra (
    id_item_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    custo_unitario_compra DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_cliente INT,
    id_funcionario INT NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario),
    FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial)
);

CREATE TABLE ItensVenda (
    id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario_venda DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);


INSERT INTO Categorias (nome) VALUES ('Alimentos'), ('Bebidas');
INSERT INTO Fornecedores (nome, cnpj, contato, endereco) VALUES ('Distribuidora Alfa', '12345678000199', 'alfa@email.com', 'Rua A, 10');
INSERT INTO Filiais (nome, endereco) VALUES ('Filial Centro', 'Av. Principal, 1000'), ('Filial Norte', 'Rua das Flores, 50');
INSERT INTO Clientes (nome, cpf, telefone, endereco) VALUES ('João Silva', '11122233344', '(11) 98888-7777', 'Rua B, 200');
INSERT INTO Funcionarios (nome, cargo, salario, data_contratacao, id_filial) VALUES ('Maria Souza', 'Operadora de Caixa', 1800.00, '2025-01-15', 1);
INSERT INTO Produtos (nome, descricao, preco, id_categoria, id_fornecedor) VALUES ('Arroz 5kg', 'Arroz Agulhinha Tipo 1', 25.90, 1, 1);
INSERT INTO EstoqueFilial (id_produto, id_filial, quantidade_estoque) VALUES (1, 1, 150), (1, 2, 85);



-- ================================================================
-- QUERYS ATIVIDADE 08


-- SELECTS E FROM

SELECT * FROM Clientes;

SELECT nome, telefone FROM Clientes;

SELECT * FROM Produtos;

SELECT nome, preco FROM Produtos;

SELECT * FROM Funcionarios;

SELECT nome, cargo FROM Funcionarios;

SELECT * FROM Vendas;

SELECT data, total FROM Compras;

SELECT descricao, preco FROM Produtos;

SELECT * FROM Filiais;

SELECT Produtos.nome, EstoqueFilial.quantidade_estoque 
FROM Produtos 
INNER JOIN EstoqueFilial ON Produtos.id_produto = EstoqueFilial.id_produto;



-- WHERE

SELECT * FROM Clientes WHERE pontos_fidelidade > 150;

SELECT * FROM Produtos WHERE preco > 50; 

SELECT * FROM Funcionarios WHERE salario > 3000;

SELECT * FROM EstoqueFilial WHERE quantidade_estoque < 10;

SELECT * FROM Compras WHERE data = '2025-01-10';

SELECT * FROM Clientes WHERE telefone IS NOT NULL;

SELECT * FROM Funcionarios WHERE cargo = 'Caixa';

-- CORREÇÃO: id_filial agora é filtrado na tabela EstoqueFilial
SELECT * FROM EstoqueFilial WHERE id_filial = 1;

SELECT * FROM Vendas WHERE total > 500;

SELECT * FROM Fornecedores WHERE nome = 'Distribuidora Alfa';



-- ORDER BY

SELECT * FROM Produtos ORDER BY nome ASC;

SELECT * FROM Produtos ORDER BY preco DESC;

SELECT * FROM Clientes ORDER BY pontos_fidelidade ASC;

SELECT * FROM Funcionarios ORDER BY salario DESC;

SELECT * FROM Vendas ORDER BY data DESC;

SELECT * FROM Compras ORDER BY total DESC;

SELECT * FROM EstoqueFilial ORDER BY quantidade_estoque ASC;

SELECT * FROM Fornecedores ORDER BY nome ASC;

SELECT * FROM Filiais ORDER BY endereco ASC;

SELECT * FROM Funcionarios ORDER BY cargo ASC, nome ASC;

SELECT * FROM Produtos ORDER BY id_categoria ASC, preco DESC;



-- GROUP BY E AGREGAÇÕES

SELECT id_categoria, COUNT(*) AS quantidade_produtos
FROM Produtos
GROUP BY id_categoria;

SELECT id_filial, SUM(total) AS total_vendas
FROM Vendas
GROUP BY id_filial;

SELECT id_filial, COUNT(*) AS quantidade_funcionarios
FROM Funcionarios 
GROUP BY id_filial;

SELECT id_fornecedor, SUM(total) AS total_compras
FROM Compras
GROUP BY id_fornecedor;

SELECT cargo, AVG(salario) AS media_salarial
FROM Funcionarios
GROUP BY cargo;

SELECT id_funcionario, COUNT(*) AS quantidade_vendas
FROM Vendas
GROUP BY id_funcionario;

SELECT id_fornecedor, COUNT(*) AS quantidade_produtos 
FROM Produtos 
GROUP BY id_fornecedor;

-- CORREÇÃO: Coluna corrigida para pontos_fidelidade
SELECT endereco, SUM(pontos_fidelidade) AS total_pontos
FROM Clientes 
GROUP BY endereco;

SELECT id_filial, COUNT(*) AS quantidade_compras
FROM Compras
GROUP BY id_filial;

SELECT id_categoria, SUM(EstoqueFilial.quantidade_estoque) AS estoque_total
FROM Produtos
INNER JOIN EstoqueFilial ON Produtos.id_produto = EstoqueFilial.id_produto
GROUP BY id_categoria;

-- CORREÇÃO: Coluna corrigida para salario
SELECT cargo, MAX(salario) AS maior_salario
FROM Funcionarios
GROUP BY cargo;



-- HAVING

SELECT id_categoria, COUNT(*) AS quantidade_produtos
FROM Produtos
GROUP BY id_categoria
HAVING COUNT(*) > 5;

SELECT id_filial, SUM(total) AS total_vendas
FROM Vendas
GROUP BY id_filial
HAVING SUM(total) > 1000;

SELECT cargo, AVG(salario) AS media_salarial
FROM Funcionarios
GROUP BY cargo
HAVING AVG(salario) > 3000;

SELECT id_fornecedor, COUNT(*) AS quantidade_produtos
FROM Produtos
GROUP BY id_fornecedor
HAVING COUNT(*) > 10;

SELECT id_funcionario, COUNT(*) AS quantidade_vendas
FROM Vendas
GROUP BY id_funcionario
HAVING COUNT(*) > 20;

SELECT id_filial, COUNT(*) AS quantidade_funcionarios
FROM Funcionarios
GROUP BY id_filial
HAVING COUNT(*) > 3;

SELECT Produtos.id_categoria, SUM(EstoqueFilial.quantidade_estoque) AS estoque_total
FROM Produtos
INNER JOIN EstoqueFilial ON Produtos.id_produto = EstoqueFilial.id_produto
GROUP BY Produtos.id_categoria
HAVING SUM(EstoqueFilial.quantidade_estoque) > 500;

SELECT id_fornecedor, SUM(total) AS total_compras
FROM Compras
GROUP BY id_fornecedor
HAVING SUM(total) > 5000;

SELECT data, COUNT(*) AS quantidade_vendas
FROM Vendas
GROUP BY data
HAVING COUNT(*) > 10;

SELECT endereco, SUM(pontos_fidelidade) AS total_pontos
FROM Clientes
GROUP BY endereco
HAVING SUM(pontos_fidelidade) > 200;

SELECT cargo, MAX(salario) AS maior_salario
FROM Funcionarios
GROUP BY cargo
HAVING MAX(salario) > 7000;


-- JOINS

SELECT Produtos.nome AS nome_produto, Categorias.nome AS nome_categoria
FROM Produtos
INNER JOIN Categorias ON Produtos.id_categoria = Categorias.id_categoria;

SELECT Produtos.nome AS nome_produto, Fornecedores.nome AS nome_fornecedor
FROM Produtos
INNER JOIN Fornecedores ON Produtos.id_fornecedor = Fornecedores.id_fornecedor;

SELECT Funcionarios.nome AS nome_funcionario, Filiais.nome AS nome_filial
FROM Funcionarios
INNER JOIN Filiais ON Funcionarios.id_filial = Filiais.id_filial;

SELECT Vendas.id_venda, Vendas.data, Clientes.nome AS nome_cliente
FROM Vendas
INNER JOIN Clientes ON Vendas.id_cliente = Clientes.id_cliente;

SELECT Compras.id_compra, Compras.data, Fornecedores.nome AS nome_fornecedor
FROM Compras
INNER JOIN Fornecedores ON Compras.id_fornecedor = Fornecedores.id_fornecedor;

SELECT ItensVenda.id_venda, Produtos.nome AS nome_produto, ItensVenda.quantidade, ItensVenda.subtotal
FROM ItensVenda
INNER JOIN Produtos ON ItensVenda.id_produto = Produtos.id_produto;

SELECT Produtos.nome AS nome_produto, Filiais.nome AS nome_filial
FROM Produtos
INNER JOIN EstoqueFilial ON Produtos.id_produto = EstoqueFilial.id_produto
INNER JOIN Filiais ON EstoqueFilial.id_filial = Filiais.id_filial;

SELECT Vendas.id_venda, Funcionarios.nome AS nome_funcionario
FROM Vendas
INNER JOIN Funcionarios ON Vendas.id_funcionario = Funcionarios.id_funcionario;

SELECT Compras.id_compra, Filiais.nome AS nome_filial, Compras.total
FROM Compras
INNER JOIN Filiais ON Compras.id_filial = Filiais.id_filial;

SELECT Clientes.nome AS nome_cliente, Vendas.id_venda, Vendas.total
FROM Clientes
INNER JOIN Vendas ON Clientes.id_cliente = Vendas.id_cliente;

SELECT Vendas.id_venda, Clientes.nome AS nome_cliente, Funcionarios.nome AS nome_funcionario, Filiais.nome AS nome_filial, Vendas.total
FROM Vendas
LEFT JOIN Clientes ON Vendas.id_cliente = Clientes.id_cliente -- LEFT JOIN pois id_cliente aceita nulo
INNER JOIN Funcionarios ON Vendas.id_funcionario = Funcionarios.id_funcionario
INNER JOIN Filiais ON Vendas.id_filial = Filiais.id_filial;
