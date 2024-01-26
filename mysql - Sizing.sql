-- Criação da tabela para armazenar as informações de crescimento
CREATE TABLE database_growth (
  id INT AUTO_INCREMENT PRIMARY KEY,
  data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  tamanho_kb DOUBLE
);

-- Criação do evento para agendar a coleta de informações
CREATE EVENT capture_database_growth
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
BEGIN
  DECLARE database_size_kb DOUBLE;
  
  -- Obtém o tamanho atual do banco de dados em kilobytes (KB)
  SELECT ROUND(SUM(data_length + index_length) / 1024) INTO database_size_kb
  FROM information_schema.tables
  WHERE table_schema = 'seu_banco_de_dados';
  
  -- Insere o tamanho obtido na tabela de crescimento do banco de dados
  INSERT INTO database_growth (tamanho_kb) VALUES (database_size_kb);
END;
