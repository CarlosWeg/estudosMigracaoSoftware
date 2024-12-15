-- Adicione uma nova coluna datacadastro em cada uma das tabelas TBPessoa e TBImovel.
-- Em seguida, atualize essas colunas para armazenar a data atual
-- no momento do cadastro de cada registro.

ALTER TABLE treina.tbpessoa
	  ADD COLUMN datacadastro DATE;

ALTER TABLE treina.tbimovel
	  ADD COLUMN datacadastro DATE;

UPDATE treina.tbpessoa
   SET datacadastro = CURRENT_DATE;

UPDATE treina.tbimovel
   SET datacadastro = CURRENT_DATE;

-- Suponha que a tabela TBPessoa passou a incluir uma coluna
-- pesdata_nascimento que armazena a data de nascimento dos indivíduos.
-- Elabore uma consulta para calcular a idade aproximada de cada pessoa
-- na tabela e exiba pesnome e a idade em anos.

SELECT p.pesnome,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE,p.datanascimento)) AS idade
  FROM treina.tbpessoa

-- Após adicionar a coluna datacadastro no exercício 1,
-- escreva uma consulta para listar todos os imóveis (imvdescricao)
-- cadastrados há mais de 1 ano.

SELECT i.imvdescricao
  FROM treina.tbimovel i
 WHERE AGE(CURRENT_DATE,i.datacadastro)>INTERVAL '1 year';

-- Imagine que você criou uma nova tabela TBPagamentos com uma coluna
-- pagdata_pagamento do tipo texto, no formato 'DD-MM-YYYY'.
-- Converta esses valores para o tipo DATE e atualize a coluna para
-- refletir essa mudança.

ALTER TABLE TREINA.TBPagamentos 
ALTER COLUMN pagdata_pagamento TYPE DATE 
USING TO_DATE(pagdata_pagamento, 'DD-MM-YYYY');