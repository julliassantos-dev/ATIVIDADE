DROP TABLE IF EXISTS Colaborador;

CREATE TABLE Colaborador (
    nome VARCHAR(100) NOT NULL,
    nascimento DATE,
    sexo CHAR(1),
    cpf VARCHAR(11) UNIQUE,
    foto BLOB
);
