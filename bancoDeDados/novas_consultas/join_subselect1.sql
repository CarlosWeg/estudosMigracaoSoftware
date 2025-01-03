SELECT * FROM DESPESAS
SELECT * FROM DEPARTAMENTOS
SELECT * FROM PROJETOS 
SELECT * FROM FUNCIONARIOS

-- Encontre o total gasto em despesas por departamento, incluindo departamentos sem despesas

SELECT dp.sigla,
       dp.nome,
	   SUM(des.valor) AS soma_despesas
  FROM departamentos dp
  LEFT JOIN despesas des ON dp.id_departamento = des.id_departamento
 GROUP BY 1,2

 -- Liste os projetos que estão atrasados (data atual > data_prevista_fim e status = 'Em andamento')

SELECT p.nome,
       p.data_prevista_fim
  FROM projetos p
 WHERE p.data_prevista_fim > CURRENT_DATE
   AND status = 'Em andamento';


-- Calcule o rank dos funcionários por salário dentro de cada departamento
SELECT f.nome,
       f.cargo,
	   f.salario,
	   f.id_departamento,
	   RANK() OVER(PARTITION BY id_departamento ORDER BY salario DESC)
  FROM funcionarios f
 ORDER BY 4,5;

 -- Encontre os funcionários que trabalham em projetos com orçamento maior que a média
SELECT f.nome,
       f.cargo
  FROM funcionarios f
 INNER JOIN departamentos d ON d.id_departamento = f.id_departamento
 INNER JOIN projetos p ON p.id_departamento = d.id_departamento
 WHERE p.orcamento > (SELECT AVG(orcamento)
                        FROM projetos);
