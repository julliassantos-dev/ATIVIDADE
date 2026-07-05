DROP TABLE IF EXISTS Livro;

CREATE TABLE Livro (
    titulo VARCHAR(200) NOT NULL,
    lancamento DATE,
    idioma CHAR(2),
    isbn VARCHAR(13) UNIQUE,
    capa BLOB
);
