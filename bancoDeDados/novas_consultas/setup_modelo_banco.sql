-- Estrutura básica municipal
CREATE TABLE municipios (
    id_municipio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    codigo_ibge INTEGER UNIQUE NOT NULL,
    populacao INTEGER,
    data_criacao DATE,
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orgaos (
    id_orgao SERIAL PRIMARY KEY,
    id_municipio INTEGER REFERENCES municipios(id_municipio),
    nome VARCHAR(150) NOT NULL,
    sigla VARCHAR(20),
    tipo_orgao VARCHAR(50),
    responsavel VARCHAR(100),
    ativo BOOLEAN DEFAULT true,
    data_criacao DATE
);

-- Recursos Humanos
CREATE TABLE cargos (
    id_cargo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    nivel VARCHAR(50),
    carga_horaria INTEGER,
    salario_base DECIMAL(10,2)
);

CREATE TABLE servidores (
    id_servidor SERIAL PRIMARY KEY,
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    id_cargo INTEGER REFERENCES cargos(id_cargo),
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    data_nascimento DATE,
    data_admissao DATE,
    tipo_vinculo VARCHAR(50),
    situacao VARCHAR(30),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE folha_pagamento (
    id_folha SERIAL PRIMARY KEY,
    id_servidor INTEGER REFERENCES servidores(id_servidor),
    mes INTEGER,
    ano INTEGER,
    salario_base DECIMAL(10,2),
    gratificacoes DECIMAL(10,2),
    descontos DECIMAL(10,2),
    valor_liquido DECIMAL(10,2),
    data_pagamento DATE
);

-- Licitações e Contratos
CREATE TABLE fornecedores (
    id_fornecedor SERIAL PRIMARY KEY,
    razao_social VARCHAR(200) NOT NULL,
    nome_fantasia VARCHAR(200),
    cnpj CHAR(14) UNIQUE NOT NULL,
    inscricao_estadual VARCHAR(20),
    endereco TEXT,
    telefone VARCHAR(20),
    email VARCHAR(100),
    ramo_atividade VARCHAR(100)
);

CREATE TABLE licitacoes (
    id_licitacao SERIAL PRIMARY KEY,
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    numero_processo VARCHAR(50) NOT NULL,
    modalidade VARCHAR(50),
    objeto TEXT,
    valor_estimado DECIMAL(15,2),
    data_abertura DATE,
    data_homologacao DATE,
    situacao VARCHAR(30)
);

CREATE TABLE contratos (
    id_contrato SERIAL PRIMARY KEY,
    id_licitacao INTEGER REFERENCES licitacoes(id_licitacao),
    id_fornecedor INTEGER REFERENCES fornecedores(id_fornecedor),
    numero_contrato VARCHAR(50) UNIQUE NOT NULL,
    objeto TEXT NOT NULL,
    valor_total DECIMAL(15,2),
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(30)
);

-- Gestão Patrimonial
CREATE TABLE categorias_bens (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    vida_util_anos INTEGER
);

CREATE TABLE bens_patrimoniais (
    id_bem SERIAL PRIMARY KEY,
    id_categoria INTEGER REFERENCES categorias_bens(id_categoria),
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    numero_tombamento VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT,
    data_aquisicao DATE,
    valor_aquisicao DECIMAL(10,2),
    estado_conservacao VARCHAR(50),
    localizacao VARCHAR(200),
    situacao VARCHAR(30)
);

-- Gestão Financeira
CREATE TABLE plano_contas (
    id_conta SERIAL PRIMARY KEY,
    codigo_conta VARCHAR(20) UNIQUE NOT NULL,
    descricao VARCHAR(200),
    tipo_conta VARCHAR(50),
    natureza VARCHAR(30)
);

CREATE TABLE orcamento_anual (
    id_orcamento SERIAL PRIMARY KEY,
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    id_conta INTEGER REFERENCES plano_contas(id_conta),
    ano INTEGER NOT NULL,
    valor_previsto DECIMAL(15,2),
    valor_suplementado DECIMAL(15,2),
    valor_anulado DECIMAL(15,2)
);

CREATE TABLE empenhos (
    id_empenho SERIAL PRIMARY KEY,
    id_orcamento INTEGER REFERENCES orcamento_anual(id_orcamento),
    id_contrato INTEGER REFERENCES contratos(id_contrato),
    numero_empenho VARCHAR(50) UNIQUE NOT NULL,
    tipo_empenho VARCHAR(30),
    data_empenho DATE,
    valor DECIMAL(15,2),
    descricao TEXT
);

-- Protocolo e Documentos
CREATE TABLE tipos_documento (
    id_tipo_documento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    prazo_dias INTEGER
);

CREATE TABLE documentos (
    id_documento SERIAL PRIMARY KEY,
    id_tipo_documento INTEGER REFERENCES tipos_documento(id_tipo_documento),
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    numero_protocolo VARCHAR(50) UNIQUE NOT NULL,
    assunto TEXT,
    data_entrada DATE,
    prazo_resposta DATE,
    status VARCHAR(30),
    interessado VARCHAR(200)
);

-- Almoxarifado
CREATE TABLE categorias_produtos (
    id_categoria_produto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    id_categoria_produto INTEGER REFERENCES categorias_produtos(id_categoria_produto),
    codigo VARCHAR(50) UNIQUE NOT NULL,
    descricao TEXT,
    unidade_medida VARCHAR(20),
    estoque_minimo INTEGER,
    estoque_atual INTEGER
);

CREATE TABLE movimentacoes_estoque (
    id_movimentacao SERIAL PRIMARY KEY,
    id_produto INTEGER REFERENCES produtos(id_produto),
    id_orgao INTEGER REFERENCES orgaos(id_orgao),
    tipo_movimentacao VARCHAR(30),
    quantidade INTEGER,
    data_movimentacao DATE,
    numero_requisicao VARCHAR(50),
    responsavel VARCHAR(100)
);

-- Inserção de dados básicos do município
INSERT INTO municipios (nome, uf, codigo_ibge, populacao, data_criacao)
VALUES ('São José dos Campos', 'SP', 3549904, 729737, '1767-07-27');

-- Inserção de órgãos municipais
INSERT INTO orgaos (id_municipio, nome, sigla, tipo_orgao, responsavel, data_criacao)
VALUES 
    (1, 'Secretaria Municipal de Administração', 'SMA', 'Administração Direta', 'Maria Silva', '2021-01-01'),
    (1, 'Secretaria Municipal de Saúde', 'SMS', 'Administração Direta', 'João Santos', '2021-01-01');

-- Inserção de cargos
INSERT INTO cargos (nome, descricao, nivel, carga_horaria, salario_base)
VALUES 
    ('Analista Administrativo', 'Responsável por análises e processos administrativos', 'Superior', 40, 4500.00),
    ('Médico Clínico Geral', 'Atendimento médico em UBS', 'Superior', 20, 8000.00);

-- Inserção de servidores
INSERT INTO servidores (id_orgao, id_cargo, nome, cpf, matricula, data_nascimento, data_admissao, tipo_vinculo, situacao, email, telefone)
VALUES 
    (1, 1, 'Ana Paula Ferreira', '12345678901', 'MAT001', '1985-03-15', '2022-02-01', 'Efetivo', 'Ativo', 'ana.ferreira@sjc.sp.gov.br', '12988887777'),
    (2, 2, 'Carlos Eduardo Santos', '98765432101', 'MAT002', '1978-07-22', '2021-06-15', 'Efetivo', 'Ativo', 'carlos.santos@sjc.sp.gov.br', '12999998888');

-- Inserção de folha de pagamento
INSERT INTO folha_pagamento (id_servidor, mes, ano, salario_base, gratificacoes, descontos, valor_liquido, data_pagamento)
VALUES 
    (1, 12, 2024, 4500.00, 500.00, 1000.00, 4000.00, '2024-12-30'),
    (2, 12, 2024, 8000.00, 1000.00, 2000.00, 7000.00, '2024-12-30');

-- Inserção de fornecedores
INSERT INTO fornecedores (razao_social, nome_fantasia, cnpj, inscricao_estadual, endereco, telefone, email, ramo_atividade)
VALUES 
    ('Tech Solutions LTDA', 'TechSol', '12345678000190', '123456789', 'Rua das Flores, 123', '1139998888', 'contato@techsol.com.br', 'Tecnologia'),
    ('Medical Supplies SA', 'MedSupply', '98765432000190', '987654321', 'Av. Principal, 456', '1138889999', 'contato@medsupply.com.br', 'Material Médico');

-- Inserção de licitações
INSERT INTO licitacoes (id_orgao, numero_processo, modalidade, objeto, valor_estimado, data_abertura, data_homologacao, situacao)
VALUES 
    (1, 'PROC2024001', 'Pregão Eletrônico', 'Aquisição de Computadores', 100000.00, '2024-01-10', '2024-02-10', 'Homologada'),
    (2, 'PROC2024002', 'Pregão Eletrônico', 'Aquisição de Material Hospitalar', 200000.00, '2024-02-01', '2024-03-01', 'Homologada');

-- Inserção de contratos
INSERT INTO contratos (id_licitacao, id_fornecedor, numero_contrato, objeto, valor_total, data_inicio, data_fim, status)
VALUES 
    (1, 1, 'CONT2024001', 'Fornecimento de Computadores', 98000.00, '2024-02-15', '2025-02-14', 'Vigente'),
    (2, 2, 'CONT2024002', 'Fornecimento de Material Hospitalar', 195000.00, '2024-03-05', '2025-03-04', 'Vigente');

-- Inserção de categorias de bens
INSERT INTO categorias_bens (nome, descricao, vida_util_anos)
VALUES 
    ('Equipamentos de Informática', 'Computadores, impressoras e periféricos', 5),
    ('Mobiliário', 'Mesas, cadeiras e armários', 10);

-- Inserção de bens patrimoniais
INSERT INTO bens_patrimoniais (id_categoria, id_orgao, numero_tombamento, descricao, data_aquisicao, valor_aquisicao, estado_conservacao, localizacao, situacao)
VALUES 
    (1, 1, 'TOMB2024001', 'Notebook Dell Latitude 5420', '2024-02-20', 5000.00, 'Novo', 'Sala 101 - Administração', 'Em uso'),
    (2, 2, 'TOMB2024002', 'Mesa de Escritório em L', '2024-03-10', 800.00, 'Novo', 'Sala 202 - Diretoria', 'Em uso');

-- Inserção no plano de contas
INSERT INTO plano_contas (codigo_conta, descricao, tipo_conta, natureza)
VALUES 
    ('3.3.90.30.00', 'Material de Consumo', 'Despesa', 'Débito'),
    ('4.4.90.52.00', 'Equipamentos e Material Permanente', 'Despesa', 'Débito');

-- Inserção de orçamento anual
INSERT INTO orcamento_anual (id_orgao, id_conta, ano, valor_previsto, valor_suplementado, valor_anulado)
VALUES 
    (1, 1, 2024, 500000.00, 50000.00, 0.00),
    (2, 2, 2024, 1000000.00, 100000.00, 0.00);

-- Inserção de empenhos
INSERT INTO empenhos (id_orcamento, id_contrato, numero_empenho, tipo_empenho, data_empenho, valor, descricao)
VALUES 
    (1, 1, 'EMP2024001', 'Ordinário', '2024-02-15', 98000.00, 'Aquisição de computadores'),
    (2, 2, 'EMP2024002', 'Ordinário', '2024-03-05', 195000.00, 'Aquisição de material hospitalar');

-- Inserção de tipos de documento
INSERT INTO tipos_documento (nome, descricao, prazo_dias)
VALUES 
    ('Memorando', 'Comunicação interna entre departamentos', 5),
    ('Ofício', 'Comunicação externa oficial', 10);

-- Inserção de documentos
INSERT INTO documentos (id_tipo_documento, id_orgao, numero_protocolo, assunto, data_entrada, prazo_resposta, status, interessado)
VALUES 
    (1, 1, 'MEM2024001', 'Solicitação de Material de Escritório', '2024-01-05', '2024-01-10', 'Finalizado', 'Departamento de RH'),
    (2, 2, 'OF2024001', 'Solicitação de Informações sobre Campanhas de Saúde', '2024-02-01', '2024-02-11', 'Em andamento', 'Secretaria Estadual de Saúde');

-- Inserção de categorias de produtos
INSERT INTO categorias_produtos (nome, descricao)
VALUES 
    ('Material de Escritório', 'Papelaria e suprimentos para escritório'),
    ('Material de Limpeza', 'Produtos para higiene e limpeza');

-- Inserção de produtos
INSERT INTO produtos (id_categoria_produto, codigo, descricao, unidade_medida, estoque_minimo, estoque_atual)
VALUES 
    (1, 'MAT001', 'Papel A4', 'Resma', 50, 200),
    (2, 'LIMP001', 'Água Sanitária', 'Litro', 20, 100);

-- Inserção de movimentações de estoque
INSERT INTO movimentacoes_estoque (id_produto, id_orgao, tipo_movimentacao, quantidade, data_movimentacao, numero_requisicao, responsavel)
VALUES 
    (1, 1, 'Entrada', 300, '2024-01-15', 'REQ2024001', 'José Silva'),
    (1, 1, 'Saída', 100, '2024-02-01', 'REQ2024002', 'Maria Oliveira');