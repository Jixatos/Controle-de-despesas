CREATE TABLE tbl_estados_rm551408 (
    sigla CHAR(2) NOT NULL,
    nome_estado VARCHAR(100) NOT NULL,
    PRIMARY KEY (sigla)
);

CREATE TABLE tbl_cidades_rm551408 (
    id_cidade INTEGER NOT NULL,
    nome_cidade VARCHAR(30) NOT NULL,
    sigla CHAR(2) NOT NULL,
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (sigla) REFERENCES tbl_estados_rm551408(sigla)
);

CREATE TABLE tbl_fornecedores_rm551408 (
    id_fornecedor INTEGER NOT NULL,
    nome VARCHAR(60) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(40) NOT NULL,
    complemento VARCHAR(8),
    cep VARCHAR(8) NOT NULL,
    id_cidade INTEGER NOT NULL,
    dt_cadastro DATE NOT NULL,
    email VARCHAR(80),
    status VARCHAR(7),
    PRIMARY KEY (id_fornecedor),
    FOREIGN KEY (id_cidade) REFERENCES tbl_cidades_rm551408(id_cidade)
);

/*
O atributo de complemento no diagrama está como NOT NULL, porém, nas planilhas não há alguns dos fornecedores que não apresentaram complemento sendo assim, irei deixar
o atributo como NULLABLE para ser possível deixar nulo.
*/

CREATE TABLE tbl_tipo_telefones_rm551408 (
    id_tipo_tel INTEGER,
    descricao VARCHAR(30),
    tbl_tipo_telefones_rm551408_ID NUMBER GENERATED ALWAYS AS IDENTITY NOT NULL,
    PRIMARY KEY (tbl_tipo_telefones_rm551408_ID)
);

CREATE TABLE tbl_telefones_rm551408 (
    id_telefone INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    numero VARCHAR(20),
    tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID NUMBER,
    PRIMARY KEY (id_telefone),
    FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores_rm551408(id_fornecedor),
    FOREIGN KEY (tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID) REFERENCES tbl_tipo_telefones_rm551408(tbl_tipo_telefones_rm551408_ID)
);

/*
O atributo numero estava como NOT NULL no diagrama, porém, na tabela um dos fornecedores não possui um número de telefone, logo, o valor entra como nulo.
Como houve um erro entre os dados fornecidos com o diagrama, irei deixar a coluna de número NULLABLE
*/

CREATE TABLE tbl_categorias_rm551408 (
    id_categoria INTEGER NOT NULL,
    descricao VARCHAR(30),
    PRIMARY KEY (id_categoria)
);

CREATE TABLE tbl_despesas_rm551408 (
    id_despesas INTEGER NOT NULL,
    dt_cadastro DATE NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    numero_docto INTEGER NOT NULL,
    parcela_atual INTEGER NOT NULL,
    parcela_maxima INTEGER NOT NULL,
    dt_vencimento DATE NOT NULL,
    valor NUMBER(10,2) NOT NULL,
    valor_pago NUMBER(10,2),
    id_categoria INTEGER NOT NULL,
    dt_pagamento DATE,
    PRIMARY KEY (id_despesas),
    FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedores_rm551408(id_fornecedor),
    FOREIGN KEY (id_categoria) REFERENCES tbl_categorias_rm551408(id_categoria)
);

/*1ª Exercício: inserir os valores que foram dados na documentação, no formato de tabela.*/
    /*Tabela - Estados*/
INSERT INTO tbl_estados_rm551408 (sigla, nome_estado) VALUES('SP','São Paulo');

SELECT * FROM tbl_estados_rm551408;

    /*Tabela - Tipo de Telefones*/
INSERT INTO tbl_tipo_telefones_rm551408(id_tipo_tel, descricao) VALUES(1, 'Telefone');
INSERT INTO tbl_tipo_telefones_rm551408(id_tipo_tel, descricao) VALUES(2, 'SAC');

SELECT * FROM tbl_tipo_telefones_rm551408;

    /*Tabela - Categorias*/
INSERT INTO tbl_categorias_rm551408(id_categoria, descricao) VALUES (1, 'Ferramentas');
INSERT INTO tbl_categorias_rm551408(id_categoria, descricao) VALUES (2, 'Serviços de T.I');
INSERT INTO tbl_categorias_rm551408(id_categoria, descricao) VALUES (3, 'Serviços Contábeis');
INSERT INTO tbl_categorias_rm551408(id_categoria, descricao) VALUES (4, 'Diversos');

SELECT * FROM tbl_categorias_rm551408;

    /*Tabela - Cidades*/
INSERT INTO tbl_cidades_rm551408(id_cidade, nome_cidade, sigla) VALUES (1, 'São Paulo','SP');
INSERT INTO tbl_cidades_rm551408(id_cidade, nome_cidade, sigla) VALUES (2, 'Campinas','SP');
INSERT INTO tbl_cidades_rm551408(id_cidade, nome_cidade, sigla) VALUES (3, 'Mariporã','SP');

SELECT * FROM tbl_cidades_rm551408;

    /*Tabela - Fornecedores*/
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, cep, id_cidade, dt_cadastro, email, status)
    VALUES(1,
        'Ferramentaria do Josué Ltda',
        'Avenida Paulista',
        '1515', 
        'Paulista',
        '01101010', 
        1, 
        '01/08/2023', 
        'fe.josue@gmail.com', 
        'ATIVO');
        
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email, status) 
    VALUES(2,
        'Flix Tecnologia e Serviços Ltda',
        'Rua Brasilia',
        '23',
        'Lapa',
        'Sala 5',
        '01101012',
        1,
        '01/08/2023',
        'flix@flix.com.br',
        'INATIVO');
        
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, cep, id_cidade, dt_cadastro, status)
    VALUES(3,
        'Rei dos Descartáveis Ltda',
        'Rua Voluntários da Pátria',
        '356',
        'Santana',
        '01106012',
        '1',
        '05/08/2023',
        'ATIVO');
        
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, cep, id_cidade, dt_cadastro, status)
    VALUES(4,
        'Manut Serviços de manutenção Ltda',
        'Avenida Aquidaban',
        '2000',
        'Centro',
        '13250123',
        2,
        '06/08/2023',
        'ATIVO');
        
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, cep, id_cidade, dt_cadastro, status)
    VALUES(5, 'Serviços de Jardinagem Ltda',
        'Rua Campinas',
        '15',
        'Centro',
        '01152222',
        3,
        '06/08/2023',
        'ATIVO');
        
INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, complemento, cep, id_cidade, dt_cadastro, email)
    VALUES(6,
        'ES Serviços Contábeis Ltda',
        'Avenida Pompéia',
        '1500',
        'Lapa',
        'Sala 10',
        '01101013',
        1,
        '06/08/2023',
        'esservicocontabeis@gmail.com');
        
SELECT * FROM tbl_fornecedores_rm551408;

    /*Tabela - Telefones*/
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(1, 1, '(11)99652532', 1);
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(2, 2, '(11)99652533', 1);
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(3, 3, '1133556677', 2);
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(4, 4,'1925526565', 1);
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(5, 5,'1156565656', 1);
INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_ID)
    VALUES(6, 6, 1);

SELECT * FROM tbl_telefones_rm551408;


    /*Tabela - Despesas*/
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)
    VALUES(1,
        '01/08/2023',
        1,
        1516,
        10,
        10,
        '15/05/2024',
        300.50,
        300.50,
        1,
        '15/08/2023');
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)
    VALUES(2,
        '15/08/2023',
        2,
        16988,
        1,
        1,
        '15/08/2023',
        1356.60,
        1356.60,
        2,
        '15/08/2023');
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)
    VALUES(3,
        '02/09/2023',
        3,
        20230902,
        1,
        1,
        '02/09/2023',
        120.00,
        120.00,
        4,
        '02/09/2023');
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)
    VALUES(4,
        '30/08/2023',
        5,
        2023080,
        3,
        3,
        '30/08/2023',
        150.00,
        150.00,
        4,
        '30/08/2023');
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, id_categoria)
    VALUES(5,
        '02/08/2023',
        5,
        2024,
        1,
        12,
        '19/01/2024',
        759.00,
        3);
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)
    VALUES(6,
        '02/08/2023',
        6,
        2023,
        1,
        5,
        '19/08/2023',
        759.60,
        759.60,
        3,
        '19/08/2023');
        
INSERT INTO tbl_despesas_rm551408
    (id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, id_categoria)
    VALUES(7,
        '03/08/2023',
        6,
        2024,
        1,
        12,
        '19/02/2024',
        0,
        3);
        
SELECT * FROM tbl_despesas_rm551408;

/*2.) Efetue as seguintes alterações nas estruturas das tabelas*/ 
    /*Tabela - Fornecedores*/
    /*a.) Valor padrão no campo dt_cadastro para a data atual*/
ALTER TABLE tbl_fornecedores_rm551408 MODIFY(dt_cadastro DEFAULT SYSDATE);
    /*b.) Campo de Status deve ser obrigatório e aceitar somente os valores ATIVO e INATIVO*/
UPDATE tbl_fornecedores_rm551408 SET status = 'INATIVO' WHERE status IS NULL;
SELECT * FROM tbl_fornecedores_rm551408;
ALTER TABLE tbl_fornecedores_rm551408 ADD CONSTRAINT status_ativo_ou_inativo_CK CHECK (status IN('ATIVO', 'INATIVO'));

    /*Tabela - Despesas*/
    /*c.) Valor padrão no campo dt_cadastro para a data atual*/
ALTER TABLE tbl_despesas_rm551408 MODIFY(dt_cadastro DEFAULT SYSDATE);

    /*d.) A data de vencimento deve ser superior ou igual a data de cadastro*/
ALTER TABLE tbl_despesas_rm551408 ADD CONSTRAINT dt_vencimento_maior_ou_igual_dt_cadastro_CK CHECK (dt_vencimento >= dt_cadastro);

    /*e.) Altere o nome do atributo dt_cadastro para dt_lancamento*/
ALTER TABLE tbl_despesas_rm551408 RENAME COLUMN dt_cadastro to dt_lancamento;

    /*f.) Adicione um atributo novo com a definição de situação em que os valores aceitos devem ser PENDENTE, PAGO, EM ATRASO*/
ALTER TABLE tbl_despesas_rm551408 ADD situacao VARCHAR(9) CONSTRAINT situacao_pendente_pago_ou_atraso_CK CHECK (situacao IN('PENDENTE','PAGO','EM ATRASO'));

    /*g.) Adicione comentários em todos os atributos para melhorar a documentação;*/
/*(id_despesas, dt_cadastro, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, valor_pago, id_categoria, dt_pagamento)*/
COMMENT ON COLUMN tbl_despesas_rm551408.id_despesas IS 'Identificação da despesa';
COMMENT ON COLUMN tbl_despesas_rm551408.dt_cadastro IS 'Data atual que foi cadastrato a despesa';
COMMENT ON COLUMN tbl_despesas_rm551408.id_fornecedor IS 'Identificação do fornecedor';
COMMENT ON COLUMN tbl_despesas_rm551408.numero_docto IS 'Número do documento';
COMMENT ON COLUMN tbl_despesas_rm551408.parcela_atual IS 'Parcela que atualmente está sendo paga ou foi paga.';
COMMENT ON COLUMN tbl_despesas_rm551408.parcela_maxima IS 'Parcela máxima quue precisa ser paga';
COMMENT ON COLUMN tbl_despesas_rm551408.dt_vencimento IS 'Data de vencimento da parcela atual';
COMMENT ON COLUMN tbl_despesas_rm551408.valor IS 'Valor total a ser pagado, divido entre as parcelas';
COMMENT ON COLUMN tbl_despesas_rm551408.valor_pago IS 'Valor total pago';
COMMENT ON COLUMN tbl_despesas_rm551408.id_categoria IS 'Identificação da categoria que o fornecedor se enquadra';
COMMENT ON COLUMN tbl_despesas_rm551408.dt_pagamento IS 'Data, da qual, ocorrou o pagamento da última parcela';

    /*h.) O valor das despesas deve ser obrigatório e maior que ZERO*/
ALTER TABLE tbl_despesas_rm551408 ADD CONSTRAINT valor_maior_que_zero_CK CHECK (valor > 0);

    /*i.) O valor de parcela_atual não deve ser maior que o parcela_maxima*/
ALTER TABLE tbl_despesas_rm551408 ADD CONSTRAINT parcela_atual_menor_parcela_maxima_CK CHECK (parcela_atual <= parcela_maxima);

/*3.) Atualize os registros conforme as solicitações*/
    /*a.) Houve uma alteração de preço dos serviços do fornecedor ES Serviços Contábeis Ltda.
A partir de 01/01/2024 em 10% calcule o valor e atualize as despesas após essa data*/
SELECT * FROM tbl_fornecedores_rm551408;
SELECT * FROM tbl_despesas_rm551408;
UPDATE tbl_despesas_rm551408
SET valor = valor * 1.10 
WHERE id_fornecedor = 1 AND SYSDATE > TO_DATE('2024-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');

    /*b.) Atualize o nome do fornecedor Manut Serviços de manutenção Ltda para Serviços de Manutenção Ltda;*/
UPDATE tbl_fornecedores_rm551408 SET nome = 'Serviços de Manutenção Ltda' WHERE nome = 'Manut Serviços de manutenção Ltda';

    /*c.) Inative todos os fornecedores que não estão na cidade de São Paulo*/
UPDATE tbl_fornecedores_rm551408 SET status = 'INATIVO' WHERE (id_cidade <> 1);

    /*d.) Adicione o seguinte fornecedor:
            Hotel Manjubinha  Congressos e Convenções Ltda.
            Rua Beira Rio, 1655  Praia Sul
            Balneário Camboriú  Santa Catarina
            CEP 22333-333
            Telefone (54) 6598-9898
*/
INSERT INTO tbl_estados_rm551408 (sigla, nome_estado) VALUES('SC','Santa Catarina');

INSERT INTO tbl_cidades_rm551408(id_cidade, nome_cidade, sigla) VALUES (4, 'Balneário Camboriú','SC');

INSERT INTO tbl_fornecedores_rm551408(id_fornecedor, nome, endereco, numero, bairro, cep, id_cidade)
    VALUES(7,
        'Hotel Manjubinha  Congressos e Convenções Ltda.',
        'Rua Beira Rio',
        '1655',
        'Praia Sul',
        '22333333',
        4);

INSERT INTO tbl_telefones_rm551408(id_telefone, id_fornecedor, numero, tbl_tipo_telefones_rm551408_tbl_tipo_telefones_rm551408_id)
VALUES(7, 7, '(54) 6598-9898', 1);

        /*e.) Adicione uma nova categoria com a descrição: Congressos e Convenções;*/
INSERT INTO tbl_categorias_rm551408 (id_categoria, descricao)
VALUES(5, 'Congressos e Convenções');

        /*f.) Adicione a despesas no valor R$ 500,00 para o Hotel Manjubinha  Congressos e Convenções Ltda, na categoria Congressos e Convenções;*/
SELECT * FROM tbl_despesas_rm551408;
INSERT INTO tbl_despesas_rm551408 (id_despesas, id_fornecedor, numero_docto, parcela_atual, parcela_maxima, dt_vencimento, valor, id_categoria)
VALUES (8,
    7,
    0001,
    1,
    2,
    '19/09/2023',
    500.00,
    5);

        /*g.) Atualize o campo de status que foi adicionado na tabela tbl_despesas_RMxxxxx conforme a condição abaixo:
Todos os registros sem data de pagamento e a data atual maior que o vencimento deve ficar como PENDENTE;
Todos os registros com data de pagamento e valor de pagamento preenchido atualizar para PAGO;
Todos os registros sem informações de pagamento e data de vencimento menor que hoje: EM ATRASO;
*/
SELECT * FROM tbl_despesas_rm551408;
UPDATE tbl_despesas_rm551408 SET situacao = 'PENDENTE' WHERE (dt_pagamento IS NULL AND SYSDATE > dt_vencimento);
UPDATE tbl_despesas_rm551408 SET situacao = 'PAGO' WHERE (dt_pagamento <> NULL AND valor_pago <> NULL );
UPDATE tbl_despesas_rm551408 SET situacao = 'EM ATRASO' WHERE (dt_vencimento < SYSDATE AND valor_pago IS NULL AND dt_pagamento IS NULL);
        
/*4.) Execute o DROP das tabelas que foram criadas*/
DROP TABLE tbl_estados_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_cidades_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_fornecedores_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_tipo_telefones_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_telefones_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_categorias_rm551408 CASCADE CONSTRAINTS;
DROP TABLE tbl_despesas_rm551408 CASCADE CONSTRAINTS;
