-- Faça uma consulta relacionando todas as tabelas, exibindo as colunas: nome da
-- pessoa, número de contato dela, descrição de seu imóvel, área do imóvel, tipo do
-- logradouro do imóvel, descrição do logradouro do imóvel. Ordene pelo nome das
-- pessoas.

SELECT p.pesnome,
       pc.ctpnumero,
       i.imvdescricao,
       (i.imvlargura * i.imvcomprimento) AS imv_area,
       l.logtipo,
       l.logdescricao
  FROM treina.tbpessoa p
  LEFT JOIN treina.tbpessoacontato pc ON p.pescodigo = pc.pescodigo
  LEFT JOIN treina.tbpessoaimovel pi ON p.pescodigo = pi.pescodigo
  LEFT JOIN treina.tbimovel i ON pi.imvcodigo = i.imvcodigo
  LEFT JOIN treina.tblogradouro l ON i.logcodigo = l.logcodigo
 ORDER BY 1