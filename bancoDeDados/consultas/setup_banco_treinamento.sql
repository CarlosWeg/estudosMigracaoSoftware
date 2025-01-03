CREATE SCHEMA TREINA; 

 

CREATE TABLE TREINA.TBLogradouro ( 

logcodigo SERIAL NOT NULL, 

logtipo CHARACTER VARYING(15) NOT NULL, 

logdescricao CHARACTER VARYING(100) NOT NULL, 

CONSTRAINT pk_tblogradouro 

PRIMARY KEY (logcodigo) 

); 

 

CREATE TABLE TREINA.TBPessoa ( 

pescodigo SERIAL NOT NULL, 

pesnome CHARACTER VARYING(50) NOT NULL, 

pessexo SMALLINT NOT NULL, 

pestipo SMALLINT NOT NULL, 

logcodigo INTEGER NOT NULL, 

CONSTRAINT pk_tbpessoa 

PRIMARY KEY (pescodigo), 

CONSTRAINT "FK TBPESSOA -> TBLOGRADOURO" 

FOREIGN KEY (logcodigo) 

REFERENCES TREINA.TBLOGRADOURO(logcodigo), 

CONSTRAINT check_pessexo CHECK (pessexo IN (1,2,3)), 

CONSTRAINT check_pestipo CHECK (pestipo IN (1,2)) 

); 

 

CREATE TABLE TREINA.TBPessoaContato ( 

pescodigo INTEGER NOT NULL, 

ctpnumero CHARACTER VARYING(20) NOT NULL, 

ctpdescricao CHARACTER VARYING(20), 

ctpramal SMALLINT, 

CONSTRAINT pk_tbpessoacontato 

PRIMARY KEY (pescodigo, ctpnumero), 

CONSTRAINT "FK TBPESSOACONTATO -> TBPESSOA" 

FOREIGN KEY (pescodigo) 

REFERENCES TREINA.TBPessoa(pescodigo) 

); 

 

CREATE TABLE TREINA.TBImovel ( 

imvcodigo SERIAL NOT NULL, 

imvdescricao CHARACTER VARYING(100) NOT NULL, 

imvlargura NUMERIC(6,2) NOT NULL, 

imvcomprimento NUMERIC(6,2) NOT NULL, 

logcodigo INTEGER NOT NULL, 

CONSTRAINT pk_tbimovel 

PRIMARY KEY (imvcodigo), 

CONSTRAINT "FK TBIMOVEL -> TBLOGRADOURO" 

FOREIGN KEY (logcodigo) 

REFERENCES TREINA.TBLogradouro(logcodigo) 

); 

 

CREATE TABLE TREINA.TBPessoaImovel ( 

pescodigo INTEGER NOT NULL, 

imvcodigo INTEGER NOT NULL, 

CONSTRAINT pk_tbpessoaimovel 

PRIMARY KEY (pescodigo, imvcodigo), 

CONSTRAINT "FK TBPESSOAIMOVEL -> TBPESSOA" 

FOREIGN KEY (pescodigo) 

REFERENCES TREINA.TBPessoa(pescodigo), 

CONSTRAINT "FK TBPESSOAIMOVEL -> TBIMOVEL" 

FOREIGN KEY (imvcodigo) 

REFERENCES TREINA.TBImovel(imvcodigo) 

); 

 

CREATE TABLE TREINA.TBTaxa ( 

pescodigo INTEGER NOT NULL, 

imvcodigo INTEGER NOT NULL, 

taxcodigo SERIAL NOT NULL, 

taxvalor NUMERIC(7,2) NOT NULL, 

CONSTRAINT pk_tbtaxa 

PRIMARY KEY (pescodigo, imvcodigo, taxcodigo), 

CONSTRAINT "FK TBTAXA -> TBPESSOA" 

FOREIGN KEY (pescodigo) 

REFERENCES TREINA.TBPessoa(pescodigo), 

CONSTRAINT "FK TBTAXA -> TBIMOVEL" 

FOREIGN KEY (imvcodigo) 

REFERENCES TREINA.TBImovel(imvcodigo) 

); 

 

/* INSERT */ 

INSERT INTO TREINA.tblogradouro( 

            logtipo, logdescricao) 

    VALUES ('RUA', 'UM'), 

           ('RUA', 'DOIS'), 

           ('RUA', 'TRES'), 

           ('RUA', 'QUATRO'), 

           ('AVENIDA', 'UM'), 

           ('AVENIDA', 'DOIS'), 

           ('AVENIDA', 'TRES'), 

           ('AVENIDA', 'QUATRO'), 

           ('TRAVESSA', 'UM'), 

           ('TRAVESSA', 'DOIS'), 

           ('TRAVESSA', 'TR S'), 

           ('TRAVESSA', 'QUATRO'); 

 

INSERT INTO TREINA.tbpessoa( 

            pesnome, pessexo, pestipo, logcodigo) 

    VALUES ('CARLOS RAMOS'    ,1,1,5), 

   ('DAVI MEDEIROS'   ,1,1,6), 

   ('RODRIGO CASTRO'   ,1,1,1), 

   ('FELIPE AUGUSTO'  ,1,1,8), 

   ('HENZO VALENTINO' ,1,1,8), 

   ('ISABELLA SILVA'  ,2,1,12), 

   ('CAMILA SANTOS'   ,2,1,1), 

   ('MARIA DAS DORES' ,2,1,2), 

   ('LOURDES DE CARMO',2,1,3), 

   ('LUANA FERREIRA'  ,2,1,4), 

   ('PASTELARIA'      ,3,2,1), 

   ('PADARIA'         ,3,2,9), 

   ('ACADEMIA'        ,3,2,10), 

   ('SUPERMERCADO'    ,3,2,11), 

   ('FARM CIA'        ,3,2,12), 

   ('POSTO'           ,3,2,4); 

    

INSERT INTO TREINA.tbimovel( 

            imvdescricao, imvlargura, imvcomprimento, logcodigo) 

        VALUES ('CASA DE ALVENARIA 1', 9.00 , 11.00,1), 

       ('CASA DE ALVENARIA 2', 9.00 , 11.00,4), 

       ('CASA DE ALVENARIA 3', 10.00, 11.00,7), 

       ('CASA DE ALVENARIA 4', 10.00, 11.00,9), 

       ('CASA DE MADEIRA 1'  , 10.00, 12.00,2), 

       ('CASA DE MADEIRA 2'  , 10.00, 12.00,5), 

       ('CASA DE MADEIRA 3'  , 9.00 , 12.00,3), 

       ('CASA DE MADEIRA 4'  , 9.00 , 12.00,1), 

       ('CASA MISTA 1'       , 11.00, 14.00,8), 

       ('CASA MISTA 2'       , 11.00, 14.00,10), 

       ('CASA MISTA 3'       , 11.00, 15.00,9), 

       ('CASA MISTA 4'       , 11.00, 15.00,6); 

       

INSERT INTO TREINA.tbpessoaimovel( 

            pescodigo, imvcodigo) 

    VALUES (1, 2), 

   (3, 4), 

   (5, 6), 

   (7, 1), 

   (9, 3), 

   (2, 5), 

   (4, 8), 

   (6, 9), 

   (8, 7), 

   (10, 8), 

   (1, 7), 

   (2, 6); 

 

INSERT INTO TREINA.tbpessoacontato( 

            pescodigo, ctpnumero, ctpdescricao, ctpramal) 

    VALUES (12, '47-98765-1436', 'CELULAR', null), 

       (9, '47-3658-9456', 'FIXO', '1599'), 

       (6, '47-96846-1436', 'CELULAR', null), 

       (5, '48-99954-4656', 'CELULAR', null), 

       (5, '48-3320-1436', 'FIXO', '1537'), 

       (1, '48-95365-1651', 'CELULAR', null), 

       (3, '49-95365-6458', 'CELULAR', null), 

       (2, '49-3576-1436', 'FIXO', '1546'), 

       (1, '49-3476-1738', 'FIXO', '1569'), 

       (7, '47-98725-1436', 'CELULAR', null), 

       (8, '48-3572-1436', 'FIXO', '1555'), 

       (3, '47-98725-1515', 'CELULAR', null), 

       (10, '49-98725-1436', 'CELULAR', null), 

       (11, '47-3372-8463', 'FIXO', '1650'), 

       (1, '50-3576-1813', 'FIXO', '1651'); 

    

INSERT INTO TREINA.tbtaxa( 

            pescodigo, imvcodigo, taxvalor) 

    VALUES (1, 2, 568.00), 

       (3, 4, 123.15), 

   (5, 6, 254.45), 

   (7, 1, 0), 

   (9, 3, 0), 

   (2, 5, 694.15), 

   (4, 8, 566.48), 

   (6, 9, 15.99), 

   (8, 7, 173.80), 

   (10, 8, 484.63), 

   (1, 7, 0), 

   (2, 6, 10); 