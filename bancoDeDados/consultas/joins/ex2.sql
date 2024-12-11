-- Consulte as pessoas e seus respectivos imóveis, exibindo as colunas de nome da
-- pessoa, código do imóvel e descrição do imóvel, inclusive das pessoas que não
-- possuem imóvel.

SELECT p.pesnome,
       i.imvcodigo,
	   i.imvdescricao
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo