MERGE INTO produtos AS t
USING (
   SELECT 
      p.id_produto, 
      p.nome, 
      p.preco, 
      CURRENT_TIMESTAMP AS data_modificacao 
   FROM produtos_stg p 
) AS s 
ON (t.id_produto = s.id_produto) 
WHEN MATCHED AND t.preco <> s.preco THEN 
   UPDATE SET 
      t.data_fim = CURRENT_TIMESTAMP, 
      t.versao = t.versao + 1 
OUTPUT 
   deleted.*, 
   CURRENT_TIMESTAMP INTO produtos_hist (id_produto, nome, preco, data_inicio, data_fim, versao, data_modificacao) 
WHEN NOT MATCHED THEN 
   INSERT (id_produto, nome, preco, data_inicio, data_fim, versao) 
   VALUES (s.id_produto, s.nome, s.preco, CURRENT_TIMESTAMP, NULL, 1);

/* 
O comando MERGE INTO é usado para mesclar os dados da tabela de origem produtos_stg com a tabela dimensão produtos.
A tabela de origem produtos_stg é selecionada na cláusula USING.
A tabela dimensão produtos é referenciada como t e a tabela de origem produtos_stg é referenciada como s.
A condição de junção ON é usada para comparar as chaves primárias das duas tabelas (id_produto).
A cláusula WHEN MATCHED AND t.preco <> s.preco THEN é usada para atualizar as colunas da tabela dimensão com os valores da tabela de origem, 
caso a junção encontre uma correspondência e o preço seja diferente.
A cláusula OUTPUT é usada para inserir as linhas antigas na tabela de histórico ` 
*/