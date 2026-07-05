ALTER TABLE Vendas
ADD id_venda INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE Vendas
ADD id_produto INT;

ALTER TABLE Vendas
ADD CONSTRAINT fk_vendas_produtos FOREIGN KEY (id_produto) REFERENCES produtos(codigo);
