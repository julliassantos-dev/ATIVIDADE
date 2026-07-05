DROP DATABASE IF EXISTS ClinicaVeterinaria;

CREATE DATABASE ClinicaVeterinaria;
USE ClinicaVeterinaria;

-- 1. especie 
CREATE TABLE especie (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- 2. raça 
CREATE TABLE raca (
    id_raca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    id_especie INT NOT NULL,
    FOREIGN KEY (id_especie) REFERENCES especie (id_especie)
);

-- 3. cliente 
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL
);

-- 4. animal
CREATE TABLE animal (
    id_animal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    descricao TEXT,
    id_raca INT NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_raca) REFERENCES raca (id_raca),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

-- 5. veterinario
CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cfmv VARCHAR(20) NOT NULL UNIQUE
);

-- 6. especialidade
CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

-- 7. especialidade veterinario
CREATE TABLE especialidade_vet (
    id_veterinario INT NOT NULL,
    id_especialidade INT NOT NULL,
    PRIMARY KEY (id_veterinario , id_especialidade),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario (id_veterinario),
    FOREIGN KEY (id_especialidade) REFERENCES especialidade (id_especialidade)
);

-- 8. consulta
CREATE TABLE consulta (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    data_consulta DATE NOT NULL,
    anotacoes TEXT,
    id_animal INT NOT NULL,
    id_veterinario INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal),
    FOREIGN KEY (id_veterinario) REFERENCES veterinario (id_veterinario) 
);

-- 9. exame
CREATE TABLE exame (
    id_exame INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor DECIMAL(10 , 2 ) NOT NULL
);

-- 10. medicamento
CREATE TABLE medicamento (
    id_medicacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor DECIMAL(10 , 2 ) NOT NULL
);

-- 11. exame realizado
CREATE TABLE exame_realizado (
    id_consulta INT NOT NULL,
    id_exame INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_consulta , id_exame),
    FOREIGN KEY (id_consulta) REFERENCES consulta (id_consulta),
    FOREIGN KEY (id_exame) REFERENCES exame (id_exame)
);

-- 12. medicacao fornecida
CREATE TABLE medicacao_fornecida (
    id_consulta INT NOT NULL,
    id_medicacao INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_consulta , id_medicacao),
    FOREIGN KEY (id_consulta) REFERENCES consulta (id_consulta),
    FOREIGN KEY (id_medicacao) REFERENCES medicamento (id_medicacao) 
);


-- =================================================================
-- INSERTS 


INSERT INTO especie (descricao) VALUES ('Cão'), ('Gato');

INSERT INTO raca (descricao, id_especie) VALUES ('Caramelo', 1), ('Siamês', 2);

INSERT INTO cliente (cpf, nome) VALUES ('123.456.789-00', 'Carlos Silva'), ('987.654.321-11', 'Ana Souza');

INSERT INTO animal (nome, idade, descricao, id_raca, id_cliente) VALUES 
('Rex', 4, 'Cão muito dócil, pelo curto', 1, 1),
('Mingau', 2, 'Gato assustado, olhos azuis', 2, 2);

INSERT INTO veterinario (nome, cfmv) VALUES ('Dr. Roberto Alves', 'CRMV-SP 12345'), ('Dra. Juliana Lima', 'CRMV-SP 67890');

INSERT INTO especialidade (descricao) VALUES ('Dermatologia'), ('Cirurgia Geral');

INSERT INTO especialidade_vet (id_veterinario, id_especialidade) VALUES (1, 1), (2, 2);

INSERT INTO consulta (data_consulta, anotacoes, id_animal, id_veterinario) VALUES 
('2026-06-20', 'Animal apresentando coceira intensa na orelha.', 1, 1),
('2026-06-21', 'Retorno para avaliação de check-up geral.', 2, 2);

INSERT INTO exame (descricao, valor) VALUES ('Hemograma Completo', 80.00), ('Raspado de Pele', 45.00);

INSERT INTO medicamento (descricao, valor) VALUES ('Antibiótico Amoxicilina', 65.50), ('Pomada Otológica', 32.00);

INSERT INTO exame_realizado (id_consulta, id_exame, quantidade) VALUES (1, 2, 1), (2, 1, 1);

INSERT INTO medicacao_fornecida (id_consulta, id_medicacao, quantidade) VALUES (1, 2, 1), (2, 1, 2);
