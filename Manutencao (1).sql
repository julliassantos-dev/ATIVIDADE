CREATE DATABASE manutencao_industrial;
USE manutencao_industrial;

-- =========================
-- TABELA MAQUINA
-- =========================
CREATE TABLE maquina (
    id_maquina INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(20),
    nome VARCHAR(100),
    setor VARCHAR(100),
    data_aquisicao DATE
);

-- =========================
-- TABELA TECNICO
-- =========================
CREATE TABLE tecnico (
    id_tecnico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf VARCHAR(20),
    especialidade VARCHAR(100)
);

-- =========================
-- TABELA PECA
-- =========================
CREATE TABLE peca (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    quantidade_disponivel INT,
    estoque_minimo INT,
    valor_unitario DECIMAL(10,2)
);

-- =========================
-- TABELA ORDEM_SERVICO
-- =========================
CREATE TABLE ordem_servico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_abertura DATE,
    data_fechamento DATE,
    status VARCHAR(50),

    id_maquina INT,
    tecnico_abertura INT,

    FOREIGN KEY (id_maquina)
        REFERENCES maquina(id_maquina),

    FOREIGN KEY (tecnico_abertura)
        REFERENCES tecnico(id_tecnico)
);

-- =========================
-- TABELA OS_TECNICO
-- =========================
CREATE TABLE os_tecnico (
    id_os INT,
    id_tecnico INT,

    PRIMARY KEY (id_os, id_tecnico),

    FOREIGN KEY (id_os)
        REFERENCES ordem_servico(id_os),

    FOREIGN KEY (id_tecnico)
        REFERENCES tecnico(id_tecnico)
);

-- =========================
-- TABELA OS_PECA
-- =========================
CREATE TABLE os_peca (
    id_os INT,
    id_peca INT,

    quantidade_utilizada INT,
    custo_momento DECIMAL(10,2),

    PRIMARY KEY (id_os, id_peca),

    FOREIGN KEY (id_os)
        REFERENCES ordem_servico(id_os),

    FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca)
);

-- =========================
-- TABELA REGISTRO_MANUTENCAO
-- =========================
CREATE TABLE registro_manutencao (
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    tempo_gasto DECIMAL(5,2),

    id_os INT,

    FOREIGN KEY (id_os)
        REFERENCES ordem_servico(id_os)
);