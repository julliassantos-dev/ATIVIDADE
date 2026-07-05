CREATE DATABASE SistemaRH;
USE SistemaRH;
DROP DATABASE SistemaRH;

CREATE TABLE cargos (
 id_cargo int auto_increment primary key,
 descricao VARCHAR(200) NOT NULL
);

CREATE TABLE departamentos(
 id_departamento int auto_increment primary key,
 nome VARCHAR(200) NOT NULL
);

CREATE TABLE funcionarios(
 id_funcionarios int auto_increment primary key,
 nome_funcionario VARCHAR(100) NOT NULL,
 data_admissao DATE NOT NULL,
 salario DECIMAL(10,2) NOT NULL,
 id_cargo INT,
 id_departamento INT,
 FOREIGN KEY(id_cargo) REFERENCES cargos(id_cargo),
 foreign key(id_departamento) REFERENCES departamentos(id_departamento)
 
);

CREATE TABLE historico_movimentacoes(

    id_movimentacao int auto_increment primary key,
    id_funcionarios int not null,
    id_departamento int not null,
    id_cargo int not null,
    data_inicio date not null,
    data_fim date,
    FOREIGN KEY(id_funcionarios) REFERENCES funcionarios(id_funcionarios),
    FOREIGN KEY(id_departamento) REFERENCES departamentos(id_departamento),
    FOREIGN KEY(id_cargo) REFERENCES cargos(id_cargo)
);

-- INSERTS 

INSERT INTO cargos (descricao) VALUES 
('Gerente'), 
('Analista'), 
('Assistente');

INSERT INTO departamentos (nome) VALUES 
('RH'), 
('Financeiro'), 
('TI');

INSERT INTO funcionarios (nome_funcionario, data_admissao, salario, id_cargo, id_departamento) VALUES 
('Ana Costa', '2024-01-15', 5500.00, 2, 1),
('Carlos Silva', '2023-06-10', 3500.00, 3, 2);

INSERT INTO historico_movimentacoes (id_funcionarios, id_cargo, id_departamento, data_inicio, data_fim) VALUES
(1, 3, 1, '2024-01-15', '2025-01-15'),
(1, 2, 1, '2025-01-16', NULL);


-- CONSULTAS 
-- Listar funcionários por departamento
SELECT f.nome_funcionario AS Funcionario, d.nome AS Departamento
FROM funcionarios f
JOIN departamentos d ON f.id_departamento = d.id_departamento;

-- Mostrar cargo atual
SELECT f.nome_funcionario AS Funcionario, c.descricao AS Cargo_Atual
FROM funcionarios f;

-- Funcionários que mudaram de cargo (com base no histórico)

SELECT id_funcionarios, COUNT(*) AS total_movimentacoes
FROM historico_movimentacoes
GROUP BY id_funcionarios
HAVING COUNT(*) > 1;
