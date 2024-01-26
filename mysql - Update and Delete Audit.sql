-- Criação da tabela de auditoria
CREATE TABLE audit_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  table_name VARCHAR(255) NOT NULL,
  action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
  record_id INT,
  username VARCHAR(255),
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TRIGGER para inserir informações de auditoria antes de realizar INSERTs, UPDATEs e DELETEs
DELIMITER $$

CREATE TRIGGER audit_trigger
BEFORE INSERT ON sua_tabela
FOR EACH ROW
BEGIN
  IF (NEW.field1 != OLD.field1 OR NEW.field2 != OLD.field2 OR ...) THEN -- Adicione aqui os campos que deseja monitorar
    INSERT INTO audit_log (table_name, action_type, record_id, username)
    VALUES ('sua_tabela', 'UPDATE', NEW.id, USER());
  END IF;
END$$

CREATE TRIGGER audit_delete_trigger
BEFORE DELETE ON sua_tabela
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, action_type, record_id, username)
  VALUES ('sua_tabela', 'DELETE', OLD.id, USER());
END$$

DELIMITER ;

-- Exemplo de uso: SELECT em sua_tabela
SELECT * FROM sua_tabela;

-- Exemplo de uso: UPDATE em sua_tabela
UPDATE sua_tabela SET field1 = 'novo_valor' WHERE id = 1;

-- Exemplo de uso: DELETE em sua_tabela
DELETE FROM sua_tabela WHERE id = 1;

-- Exemplo de uso: SELECT nos logs de auditoria
SELECT * FROM audit_log;
