CREATE TABLE USUARIO 
(
  LOGIN VARCHAR2(12 BYTE) NOT NULL 
, NOME VARCHAR2(80 BYTE) NOT NULL 
, SENHA VARCHAR2(24 BYTE) 
, EMAIL VARCHAR2(241 BYTE) 
, STATUS NUMBER NOT NULL 
, CONSTRAINT PK_USUARIO PRIMARY KEY 
  (
    LOGIN 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "USERS" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);

COMMENT ON COLUMN USUARIO.EMAIL IS 'E-mail utilizado para entrar em contato com o usu�rio';
COMMENT ON COLUMN USUARIO.STATUS IS '1 = ATIVO
2 = BLOQUEADO';

CREATE TABLE USUARIOPERFIL 
(
  LOGIN VARCHAR2(12 BYTE) NOT NULL 
, PERFIL NUMBER NOT NULL 
, CONSTRAINT USUARIOPERFIL_PK PRIMARY KEY 
  (
    LOGIN 
  , PERFIL 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "USERS" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);

ALTER TABLE USUARIOPERFIL
ADD CONSTRAINT FK_USUARIOPERFIL_USUARIO FOREIGN KEY
(
  LOGIN 
)
REFERENCES USUARIO
(
  LOGIN 
)
ENABLE;

ALTER TABLE USUARIOPERFIL
ADD CONSTRAINT CHK_USUARIOPERFIL_PERFIL CHECK 
(PERFIL BETWEEN 1 AND 4)
ENABLE;

COMMENT ON COLUMN USUARIOPERFIL.PERFIL IS '1 = Comprador Suprimentos;
2 = Comprador Log�stica;
3 = Fornecedor;
4 = Administrador';

INSERT INTO USUARIO
(Nome, Login, Senha, Email, Status)
VALUES
('Administrador Fusion', 'admfusion', 'nMt6vfHriwbmCFAim+R8qw==','mauro.leal@fusionconsultoria.com.br', 1)
;
INSERT INTO USUARIOPERFIL
(Login, Perfil)
VALUES
('admfusion',4);
COMMIT;
CREATE TABLE PRODUTO
(
    Codigo VARCHAR2(18) NOT NULL,
    Descricao VARCHAR2(40) NOT NULL,
	Tipo VARCHAR2(4) NOT NULL
)
;
ALTER TABLE PRODUTO ADD CONSTRAINT PK_PRODUTO
  PRIMARY KEY (
  Codigo
)
 ENABLE 
 VALIDATE 
 ;
CREATE TABLE FORNECEDOR
(
    Codigo VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(35) NOT NULL,
	Email VARCHAR2(100) NULL
)
;
ALTER TABLE FORNECEDOR ADD CONSTRAINT PK_FORNECEDOR
  PRIMARY KEY (
  Codigo
)
 ENABLE 
 VALIDATE 
;

--TABELA PRODUTOFORNECEDOR (INICIO)
CREATE TABLE PRODUTOFORNECEDOR
(
    CodigoProduto VARCHAR2(18),
    CodigoFornecedor VARCHAR2(10)
)
;
ALTER TABLE PRODUTOFORNECEDOR ADD CONSTRAINT PK_PRODUTOFORNECEDOR
PRIMARY KEY (CodigoProduto, CodigoFornecedor)
ENABLE
VALIDATE
;
ALTER TABLE PRODUTOFORNECEDOR ADD CONSTRAINT FK_PRODUTOFORNECEDOR_PRODUTO
foreign KEY (CodigoProduto) REFERENCES PRODUTO(Codigo)
;
ALTER TABLE PRODUTOFORNECEDOR ADD CONSTRAINT FK_PRODUTOFORNECEDOR_FORNEC
foreign KEY (CodigoFornecedor) REFERENCES fornecedor(Codigo)
;

--TABLEA PRODUTOFORNECEDOR (FIM)

--TABELA CONDI��O DE PAGAMENTO (INICIO)
CREATE TABLE CONDICAOPAGAMENTO
(
    Codigo VARCHAR2(4) NOT NULL,
    Descricao VARCHAR2(50) NOT NULL
)
;
ALTER TABLE CONDICAOPAGAMENTO ADD CONSTRAINT PK_CONDICAOPAGAMENTO
  PRIMARY KEY (
  Codigo
)
 ENABLE 
 VALIDATE 
;
--TABELA CONDI��O DE PAGAMENTO (FIM)

--TABELA IVA (INICIO)
CREATE TABLE IVA
(
    Codigo VARCHAR2(2) NOT NULL,
    Descricao VARCHAR2(50) NOT NULL
)
;
ALTER TABLE IVA ADD CONSTRAINT PK_IVA
  PRIMARY KEY (
  Codigo
)
 ENABLE 
 VALIDATE ;
--TABELA IVA (FIM)

--INCOTERM (INICIO)

  CREATE TABLE "INCOTERM" 
   (	"CODIGO" VARCHAR2(3 BYTE) NOT NULL ENABLE, 
	"DESCRICAO" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "PK_INCOTERM" PRIMARY KEY ("CODIGO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;

--INCOTERM (FIM)

--REQUISICAO DE COMPRA (INICIO)
CREATE TABLE REQUISICAOCOMPRA 
(
  ID NUMBER NOT NULL 
, NUMERO VARCHAR2(10) NOT NULL 
, NUMEROITEM VARCHAR2(5) NOT NULL 
, LOGINCRIADOR VARCHAR2(12) NOT NULL 
, REQUISITANTE VARCHAR2(12) NULL 
, CODIGOFORNECEDORPRETENDIDO VARCHAR2(20) NULL 
, DESCRICAO VARCHAR2(40) NOT NULL 
, CODIGOMATERIAL VARCHAR2(18) NOT NULL 
, QUANTIDADE NUMBER(13, 3) NOT NULL 
, UNIDADEMEDIDA VARCHAR2(3) NOT NULL 
, CENTRO VARCHAR2(4) NOT NULL 
, DATASOLICITACAO DATE NOT NULL 
, DATALIBERACAO DATE NOT NULL 
, DATAREMESSA DATE NOT NULL 
, CONSTRAINT PK_REQUISICAODECOMPRA PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT UK_REQUISICAODECOMPRA UNIQUE 
(
  NUMERO 
, NUMEROITEM 
)
ENABLE;

ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT FK_REQCOMPRA_CRIADOR FOREIGN KEY
(
  LOGINCRIADOR 
)
REFERENCES USUARIO
(
  LOGIN 
)
ENABLE;

ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT FK_REQCOMPRA_FORNEC FOREIGN KEY
(
  CODIGOFORNECEDORPRETENDIDO 
)
REFERENCES FORNECEDOR
(
  CODIGO 
)
ENABLE;

ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT FK_REQCOMPRA_MATERIAL FOREIGN KEY
(
  CODIGOMATERIAL 
)
REFERENCES PRODUTO
(
  CODIGO 
)
ENABLE;

COMMENT ON COLUMN REQUISICAOCOMPRA.ID IS 'Chave da Tabela';

COMMENT ON COLUMN REQUISICAOCOMPRA.LOGINCRIADOR IS 'Usuario que criou a Requisicao';

COMMENT ON COLUMN REQUISICAOCOMPRA.REQUISITANTE IS 'Usuario que fez a requisicao';

CREATE SEQUENCE REQUISICAOCOMPRA_ID_SEQUENCE INCREMENT BY 1 START WITH 1;
--REQUISICAO DE COMPRA (FIM)

--PROCESSO DE COTACAO (INICIO )

CREATE TABLE "PROCESSOCOTACAO" 
   ("ID" NUMBER NOT NULL ENABLE, 
	"DATALIMITERETORNO" DATE, 
	"STATUS" NUMBER NOT NULL ENABLE, 
	"CODIGOPRODUTO" VARCHAR2(18 BYTE) NOT NULL ENABLE, 
	"QUANTIDADE" NUMBER(13,3) NOT NULL ENABLE, 
	 CONSTRAINT "PK_PROCESSOCOTACAO" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FK_PROCESSOCOTACAO_PRODUTO" FOREIGN KEY ("CODIGOPRODUTO")
	  REFERENCES "PRODUTO" ("CODIGO") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
 --PROCESSO DE COTACAO (FIM)
 
 --PROCESSO DE COTA��O DE MATERIAL (INICIO)
 
  CREATE TABLE "PROCESSOCOTACAOMATERIAL" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"IDREQUISICAOCOMPRA" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "PROCESSOCOTACAOMATERIAL_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "FK_PROCESSOMATERIAL_PROCESSO" FOREIGN KEY ("ID")
	  REFERENCES "PROCESSOCOTACAO" ("ID") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
  CREATE SEQUENCE PROCESSOCOTACAO_ID_SEQUENCE INCREMENT BY 1 START WITH 1;

 
 --PROCESSO DE COTA��O DE MATERIAL (FIM)
 
 --COTACAO (INICIO)
CREATE TABLE COTACAO 
(
  SELECIONADA NUMBER(1, 0) DEFAULT 0 NOT NULL 
, VALORLIQUIDO NUMBER(13, 2) NOT NULL 
, CODIGOINCOTERM VARCHAR2(3 BYTE) NOT NULL 
, DESCRICAOINCOTERM VARCHAR2(40 BYTE) NOT NULL 
, QUANTIDADEADQUIRIDA NUMBER(13, 3) 
, CODIGOIVA VARCHAR2(2 BYTE) 
, CODIGOCONDICAOPAGAMENTO VARCHAR2(4 BYTE) NOT NULL 
, ID NUMBER NOT NULL 
, VALORCOMIMPOSTOS NUMBER(13, 2) 
, MVA NUMBER(13, 2) 
, CONSTRAINT COTACAO_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "USERS" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);

ALTER TABLE COTACAO
ADD CONSTRAINT FK_COTACAO_CONDICAOPAGAMENTO FOREIGN KEY
(
  CODIGOCONDICAOPAGAMENTO
)
REFERENCES CONDICAOPAGAMENTO
(
  CODIGO 
)
ENABLE;

ALTER TABLE COTACAO
ADD CONSTRAINT FK_COTACAO_INCOTERM FOREIGN KEY
(
  CODIGOINCOTERM 
)
REFERENCES INCOTERM
(
  CODIGO 
)
ENABLE;

ALTER TABLE COTACAO
ADD CONSTRAINT FK_COTACAO_IVA FOREIGN KEY
(
  CODIGOIVA 
)
REFERENCES IVA
(
  CODIGO 
)
ENABLE;

ALTER TABLE COTACAO
ADD CONSTRAINT COTACAO_SELECIONADA CHECK 
(SELECIONADA BETWEEN 0 AND 1)
ENABLE;

CREATE SEQUENCE COTACAO_ID_SEQUENCE INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

--COTACAO (FIM)


--FORNECEDOR PARTICIPANTE (INICIO)
CREATE TABLE FORNECEDORPARTICIPANTE 
(
  IDPROCESSOCOTACAO NUMBER NOT NULL 
, CODIGOFORNECEDOR VARCHAR2(10 BYTE) NOT NULL 
, ID NUMBER NOT NULL 
, IDCOTACAO NUMBER 
, CONSTRAINT PK_FORNECEDORPARTICIPANTE PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "USERS" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);

ALTER TABLE FORNECEDORPARTICIPANTE
ADD CONSTRAINT UK_PROCESSO_FORNECEDOR UNIQUE 
(
  IDPROCESSOCOTACAO 
, CODIGOFORNECEDOR 
)
ENABLE;

ALTER TABLE FORNECEDORPARTICIPANTE
ADD CONSTRAINT FK_FORNECPARTICIPANTE_COTACAO FOREIGN KEY
(
  IDCOTACAO 
)
REFERENCES COTACAO
(
  ID 
)
ENABLE;

ALTER TABLE FORNECEDORPARTICIPANTE
ADD CONSTRAINT FK_PROCESSOFORNECEDOR_FORNEC FOREIGN KEY
(
  CODIGOFORNECEDOR 
)
REFERENCES FORNECEDOR
(
  CODIGO 
)
ENABLE;

ALTER TABLE FORNECEDORPARTICIPANTE
ADD CONSTRAINT FK_PROCESSOFORNECEDOR_PROCESSO FOREIGN KEY
(
  IDPROCESSOCOTACAO 
)
REFERENCES PROCESSOCOTACAO
(
  ID 
)
ENABLE;

CREATE SEQUENCE FORNECPARTICIPANTE_ID_SEQUENCE INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

--FORNECEDOR PARTICIPANTE (FIM)

--COTACAOIMPOSTO (INICIO)
CREATE TABLE COTACAOIMPOSTO 
(
  IDCOTACAO NUMBER NOT NULL 
, TIPOIMPOSTO NUMBER NOT NULL 
, ALIQUOTA NUMBER(4, 2) NOT NULL 
, VALOR NUMBER(13, 2) NOT NULL 
, CONSTRAINT COTACAOIMPOSTO_PK PRIMARY KEY 
  (
    IDCOTACAO 
  , TIPOIMPOSTO 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE "USERS" 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS 2147483645 
  BUFFER_POOL DEFAULT 
);

ALTER TABLE COTACAOIMPOSTO
ADD CONSTRAINT COTACAOIMPOSTO_COTACAO FOREIGN KEY
(
  IDCOTACAO 
)
REFERENCES COTACAO
(
  ID 
)
ENABLE;

--COTACAOIMPOSTO (FIM)

--ITINERARIO (INICIO)
CREATE TABLE ITINERARIO 
(
  CODIGO VARCHAR2(6 BYTE) NOT NULL 
, DESCRICAO VARCHAR2(40 BYTE) NOT NULL 
, CONSTRAINT PK_ITINERARIO PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
);
--ITINERARIO (FIM)

--UNIDADE DE MEDIDA (INICIO)
CREATE TABLE UNIDADEMEDIDA 
(
  CODIGOINTERNO VARCHAR2(3) NOT NULL 
, CODIGOEXTERNO VARCHAR2(3) NOT NULL 
, DESCRICAO VARCHAR2(30) NOT NULL 
, CONSTRAINT PK_UNIDADEMEDIDA PRIMARY KEY 
  (
    CODIGOINTERNO 
  )
  ENABLE 
);
--UNIDADE DE MEDIDA (FIM)
