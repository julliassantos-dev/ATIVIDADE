ALTER TABLE Projeto
ADD id_projeto INTEGER PRIMARY KEY;

ALTER TABLE Projeto
ADD id_gerente INT;

ALTER TABLE Projeto
ADD CONSTRAINT fk_projeto_gerente FOREIGN KEY (
id_gerente) REFERENCES Gerente(
id);
