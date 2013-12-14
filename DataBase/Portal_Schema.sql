CREATE TABLE USUARIO 
(
  LOGIN VARCHAR2(12 BYTE) NOT NULL 
, NOME VARCHAR2(80 CHAR) NOT NULL 
, SENHA VARCHAR2(24 CHAR) 
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
(PERFIL BETWEEN 1 AND 7)
ENABLE;

COMMENT ON COLUMN USUARIOPERFIL.PERFIL IS '1 = Comprador Suprimentos;
2 = Comprador Log�stica;
3 = Fornecedor;
4 = Administrador
5 = Gerenciador de Quotas;
6 = Agendador de Cargas
7 = Conferidor de Cargas';

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
    Descricao VARCHAR2(40 CHAR) NOT NULL,
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
  CODIGO VARCHAR2(10 BYTE) NOT NULL 
, NOME VARCHAR2(35 CHAR) NOT NULL 
, EMAIL VARCHAR2(100 BYTE) 
, CNPJ VARCHAR2(16 CHAR) 
, MUNICIPIO VARCHAR2(35 CHAR) 
, UF VARCHAR2(3 CHAR)
, TRANSPORTADORA NUMBER(1,0) NOT NULL
, CONSTRAINT PK_FORNECEDOR PRIMARY KEY 
  (
    CODIGO 
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

ALTER TABLE FORNECEDOR
ADD CONSTRAINT CHK_FORNECEDOR_TRANSPORTADORA CHECK 
(TRANSPORTADORA BETWEEN 0 AND 1)
ENABLE;

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
    Descricao VARCHAR2(50 CHAR) NOT NULL
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
    Descricao VARCHAR2(50 CHAR) NOT NULL
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
CREATE TABLE INCOTERM 
(
  CODIGO VARCHAR2(3 BYTE) NOT NULL 
, DESCRICAO VARCHAR2(30 CHAR) NOT NULL 
, CONSTRAINT PK_INCOTERM PRIMARY KEY 
  (
    CODIGO 
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

--INCOTERM (FIM)

--UNIDADE DE MEDIDA (INICIO)
CREATE TABLE UNIDADEMEDIDA 
(
  CODIGOINTERNO VARCHAR2(3 CHAR) NOT NULL 
, CODIGOEXTERNO VARCHAR2(3 CHAR) NOT NULL 
, DESCRICAO VARCHAR2(30 CHAR) NOT NULL 
, CONSTRAINT PK_UNIDADEMEDIDA PRIMARY KEY 
  (
    CODIGOINTERNO 
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
--UNIDADE DE MEDIDA (FIM)

--ITINERARIO (INICIO)
CREATE TABLE ITINERARIO 
(
  CODIGO VARCHAR2(6 BYTE) NOT NULL 
, DESCRICAO VARCHAR2(40 CHAR) NOT NULL 
, CONSTRAINT PK_ITINERARIO PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
);
--ITINERARIO (FIM)

--REQUISICAO DE COMPRA (INICIO)
CREATE TABLE REQUISICAOCOMPRA 
(
  ID NUMBER NOT NULL 
, NUMERO VARCHAR2(10 BYTE) NOT NULL 
, NUMEROITEM VARCHAR2(5 BYTE) NOT NULL 
, LOGINCRIADOR VARCHAR2(12 BYTE) NOT NULL 
, REQUISITANTE VARCHAR2(12 CHAR) 
, CODIGOFORNECEDORPRETENDIDO VARCHAR2(20 BYTE) 
, DESCRICAO VARCHAR2(40 CHAR) NOT NULL 
, CODIGOMATERIAL VARCHAR2(18 BYTE) NOT NULL 
, QUANTIDADE NUMBER(13, 3) NOT NULL 
, UNIDADEMEDIDA VARCHAR2(3 CHAR) NOT NULL 
, CENTRO VARCHAR2(4 BYTE) NOT NULL 
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

ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT FK_REQCOMPRA_UNIDADEMEDIDA FOREIGN KEY
(
  UNIDADEMEDIDA 
)
REFERENCES UNIDADEMEDIDA
(
  CODIGOINTERNO 
)
ENABLE;

COMMENT ON COLUMN REQUISICAOCOMPRA.ID IS 'Chave da Tabela';

COMMENT ON COLUMN REQUISICAOCOMPRA.LOGINCRIADOR IS 'Usuario que criou a Requisicao';

COMMENT ON COLUMN REQUISICAOCOMPRA.REQUISITANTE IS 'Usuario que fez a requisicao';

CREATE SEQUENCE REQUISICAOCOMPRA_ID_SEQUENCE INCREMENT BY 1 START WITH 1;

--REQUISICAO DE COMPRA (FIM)

--PROCESSO DE COTACAO (INICIO )
CREATE TABLE PROCESSOCOTACAO 
(
  ID NUMBER NOT NULL 
, DATALIMITERETORNO DATE 
, STATUS NUMBER NOT NULL 
, CODIGOPRODUTO VARCHAR2(18 BYTE) NOT NULL 
, QUANTIDADE NUMBER(13, 3) NOT NULL 
, CODIGOUNIDADEMEDIDA VARCHAR2(3 CHAR) NOT NULL
, REQUISITOS CLOB NULL
, CONSTRAINT PK_PROCESSOCOTACAO PRIMARY KEY 
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

ALTER TABLE PROCESSOCOTACAO
ADD CONSTRAINT FK_PROCESSOCOTACAO_PRODUTO FOREIGN KEY
(
  CODIGOPRODUTO 
)
REFERENCES PRODUTO
(
  CODIGO 
)
ENABLE;

ALTER TABLE PROCESSOCOTACAO
ADD CONSTRAINT FK_PROCESSOCOTACAO_UNIDADE FOREIGN KEY
(
  CODIGOUNIDADEMEDIDA 
)
REFERENCES UNIDADEMEDIDA
(
  CODIGOINTERNO 
)
ENABLE;

  
 --PROCESSO DE COTACAO (FIM)
 
 --PROCESSO DE COTA��O DE MATERIAL (INICIO)
 
CREATE TABLE PROCESSOCOTACAOMATERIAL 
(
  ID NUMBER NOT NULL 
, IDREQUISICAOCOMPRA NUMBER NOT NULL 
, CONSTRAINT PROCESSOCOTACAOMATERIAL_PK PRIMARY KEY 
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

ALTER TABLE PROCESSOCOTACAOMATERIAL
ADD CONSTRAINT FK_PROCESSOMATERIAL_PROCESSO FOREIGN KEY
(
  ID 
)
REFERENCES PROCESSOCOTACAO
(
  ID 
)
ENABLE;
  
CREATE SEQUENCE PROCESSOCOTACAO_ID_SEQUENCE INCREMENT BY 1 START WITH 1;

 
 --PROCESSO DE COTA��O DE MATERIAL (FIM)
 
 --PROCESSO DE COTACAO DE FRETE (INICIO)
 CREATE TABLE PROCESSOCOTACAOFRETE 
(
  ID NUMBER NOT NULL 
, CODIGOITINERARIO VARCHAR2(6 BYTE) NOT NULL 
, NUMEROCONTRATO VARCHAR2(20 CHAR) NULL 
, DATAVALIDADEINICIAL DATE NOT NULL 
, DATAVALIDADEFINAL DATE NOT NULL 
, CONSTRAINT PROCESSOCOTACAOFRETE_PK PRIMARY KEY 
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

ALTER TABLE PROCESSOCOTACAOFRETE
ADD CONSTRAINT FK_COTACAOFRETE_ITINERARIO FOREIGN KEY
(
  CODIGOITINERARIO 
)
REFERENCES ITINERARIO
(
  CODIGO 
)
ENABLE;

ALTER TABLE PROCESSOCOTACAOFRETE
ADD CONSTRAINT FK_COTACAOFRETE_PROCESSO FOREIGN KEY
(
  ID 
)
REFERENCES PROCESSOCOTACAO
(
  ID 
)
ENABLE;
 --PROCESSO DE COTACAO DE FRETE (FIM)
 
 --COTACAO (INICIO)
CREATE TABLE COTACAO 
(
  SELECIONADA NUMBER(1, 0) DEFAULT 0 NOT NULL 
, VALORLIQUIDO NUMBER(13, 2) NOT NULL 
, QUANTIDADEADQUIRIDA NUMBER(13, 3) 
, ID NUMBER NOT NULL 
, VALORCOMIMPOSTOS NUMBER(13, 2) 
, QUANTIDADEDISPONIVEL NUMBER(13, 3) NOT NULL 
, OBSERVACOES CLOB 
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
) 
LOB (OBSERVACOES) STORE AS SYS_LOB0000021766C00007$$ 
( 
  ENABLE STORAGE IN ROW 
  CHUNK 8192 
  RETENTION 
  NOCACHE 
  LOGGING 
  TABLESPACE "USERS" 
  STORAGE 
  ( 
    INITIAL 65536 
    NEXT 1048576 
    MINEXTENTS 1 
    MAXEXTENTS 2147483645 
    BUFFER_POOL DEFAULT 
  )  
);

ALTER TABLE COTACAO
ADD CONSTRAINT COTACAO_SELECIONADA CHECK 
(SELECIONADA BETWEEN 0 AND 1)
ENABLE;

CREATE SEQUENCE COTACAO_ID_SEQUENCE INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

--COTACAO (FIM)

--COTACAOMATERIAL (INICIO)
CREATE TABLE COTACAOMATERIAL 
(
  ID NUMBER NOT NULL 
, CODIGOINCOTERM VARCHAR2(3 BYTE) NOT NULL 
, DESCRICAOINCOTERM VARCHAR2(40 CHAR) NOT NULL 
, CODIGOCONDICAOPAGAMENTO VARCHAR2(4 BYTE) NOT NULL 
, PRAZOENTREGA DATE NOT NULL 
, CODIGOIVA VARCHAR2(2 BYTE) 
, MVA NUMBER(13, 2) 
, CONSTRAINT COTACAOMATERIAL_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE COTACAOMATERIAL
ADD CONSTRAINT COTACAOMATERIAL_COTACAO_FK1 FOREIGN KEY
(
  ID 
)
REFERENCES COTACAO
(
  ID 
)
ENABLE;

ALTER TABLE COTACAOMATERIAL
ADD CONSTRAINT FK_COTACAOMATERIAL_CONDICAO FOREIGN KEY
(
  CODIGOCONDICAOPAGAMENTO 
)
REFERENCES CONDICAOPAGAMENTO
(
  CODIGO 
)
ENABLE;

ALTER TABLE COTACAOMATERIAL
ADD CONSTRAINT FK_COTACAOMATERIAL_INCOTERM FOREIGN KEY
(
  CODIGOINCOTERM 
)
REFERENCES INCOTERM
(
  CODIGO 
)
ENABLE;

ALTER TABLE COTACAOMATERIAL
ADD CONSTRAINT FK_COTACAOMATERIAL_IVA FOREIGN KEY
(
  CODIGOIVA 
)
REFERENCES IVA
(
  CODIGO 
)
ENABLE;
--COTACAOMATERIAL (FIM)

--COTACAOFRETE(INICIO)
CREATE TABLE COTACAOFRETE 
(
  ID NUMBER NOT NULL 
, CONSTRAINT COTACAOFRETE_PK PRIMARY KEY 
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

ALTER TABLE COTACAOFRETE
ADD CONSTRAINT FK_COTACAOFRETE_COTACAO FOREIGN KEY
(
  ID 
)
REFERENCES COTACAO
(
  ID 
)
ENABLE;

--COTACAOFRETE (FIM)

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

--QUOTA (INICIO)
CREATE TABLE QUOTA 
(
  DATA DATE NOT NULL 
, CODIGOTERMINAL VARCHAR2(4 CHAR) NOT NULL 
, CODIGOFORNECEDOR VARCHAR2(12 BYTE) NOT NULL 
, FLUXODECARGA NUMBER NOT NULL 
, PESOTOTAL NUMBER(13, 3) NOT NULL 
, CODIGOMATERIAL NUMBER NOT NULL 
, PESOAGENDADO NUMBER(13, 3) NOT NULL 
, PESOREALIZADO NUMBER(13, 3) NOT NULL
, ID NUMBER NOT NULL 
, CONSTRAINT PK_QUOTA PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
) ;

ALTER TABLE QUOTA
ADD CONSTRAINT UK_QUOTA UNIQUE 
(
  DATA 
, CODIGOTERMINAL 
, CODIGOFORNECEDOR 
, CODIGOMATERIAL 
)
ENABLE;

ALTER TABLE QUOTA
ADD CONSTRAINT FK_QUOTA_TRANSPORTADORA FOREIGN KEY
(
  CODIGOFORNECEDOR 
)
REFERENCES FORNECEDOR
(
  CODIGO 
)
ENABLE;

ALTER TABLE QUOTA
ADD CONSTRAINT CHK_QUOTA_FLUXODECARGA CHECK 
(FLUXODECARGA BETWEEN 1 AND 2)
ENABLE;

ALTER TABLE QUOTA
ADD CONSTRAINT CHK_QUOTA_MATERIAL CHECK 
(CODIGOMATERIAL BETWEEN 1 AND 2)
ENABLE;

COMMENT ON COLUMN QUOTA.FLUXODECARGA IS '1 = Carregamento
2 = Descarregamento';

COMMENT ON COLUMN QUOTA.CODIGOMATERIAL IS '1 = Soja
2 = Farelo';


CREATE SEQUENCE QUOTA_ID_SEQUENCE INCREMENT BY 1 START WITH 1;

--QUOTA (FIM)

--AGENDAMENTO DE CARGA (INICIO)
CREATE TABLE AGENDAMENTODECARGA 
(
  ID NUMBER NOT NULL 
, PLACA VARCHAR2(8 CHAR) NOT NULL 
, REALIZADO NUMBER(1, 0) NOT NULL 
, IDQUOTA NUMBER NOT NULL
, PESOTOTAL NUMBER(13,3) NOT NULL
, CONSTRAINT PK_AGENDAMENTODECARGA PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE AGENDAMENTODECARGA
ADD CONSTRAINT FK_AGENDAMENTODECARGA_QUOTA FOREIGN KEY
(
  IDQUOTA 
)
REFERENCES QUOTA
(
  ID 
)
ENABLE;

ALTER TABLE AGENDAMENTODECARGA
ADD CONSTRAINT CHK_AGENDAMENTOCARGA_REALIZADO CHECK 
(REALIZADO BETWEEN 0 AND 1)
ENABLE;
CREATE SEQUENCE AGENDAMENTODECARGA_ID_SEQUENCE INCREMENT BY 1 START WITH 1;

--AGENDAMENTO DE CARGA (FIM)

--AGENDAMENTO DE CARREGAMENTO (INICIO)
CREATE TABLE AGENDAMENTODECARREGAMENTO 
(
  ID NUMBER NOT NULL 
, PESO NUMBER(13, 3) NOT NULL 
, CONSTRAINT PK_AGENDAMENTODECARREGAMENTO PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE AGENDAMENTODECARREGAMENTO
ADD CONSTRAINT FK_CARREGAMENTO_AGENDAMENTO FOREIGN KEY
(
  ID 
)
REFERENCES AGENDAMENTODECARGA
(
  ID 
)
ENABLE;

--AGENDAMENTO DE CARREGAMENTO (FIM)

--AGENDAMENTO DE DESCARREGAMENTO (INICIO)
CREATE TABLE AGENDAMENTODEDESCARREGAMENTO 
(
  ID NUMBER NOT NULL 
, CONSTRAINT PK_AGENDAMENTODESCARREGAMENTO PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE AGENDAMENTODEDESCARREGAMENTO
ADD CONSTRAINT FK_DESCARREGAMENTO_AGENDAMENTO FOREIGN KEY
(
  ID 
)
REFERENCES AGENDAMENTODECARGA
(
  ID 
)
ENABLE;

--AGENDAMENTO DE DESCARREGAMENTO (FIM)

--NOTAFISCAL (INICIO)
CREATE TABLE NOTAFISCAL 
(
  NUMERO VARCHAR2(9) NOT NULL 
, SERIE VARCHAR2(3 CHAR) NOT NULL 
, CNPJEMITENTE VARCHAR2(16 CHAR) NOT NULL 
, NOMEEMITENTE VARCHAR2(35 CHAR) NOT NULL 
, CNPJCONTRATANTE VARCHAR2(16 CHAR) 
, NOMECONTRATANTE VARCHAR2(35 CHAR)
, DATAEMISSAO DATE NOT NULL 
, NUMEROCONTRATO VARCHAR2(20 CHAR) 
, PESO NUMBER(13, 3) NOT NULL 
, VALOR NUMBER(13, 2) NOT NULL 
, IDAGENDAMENTODESCARREGAMENTO NUMBER NOT NULL 
, CONSTRAINT PK_NOTAFISCAL PRIMARY KEY 
  (
    NUMERO 
  , SERIE 
  , CNPJEMITENTE 
  )
  ENABLE 
);

ALTER TABLE NOTAFISCAL
ADD CONSTRAINT FK_NOTA_DESCARREGAMENTO FOREIGN KEY
(
  IDAGENDAMENTODESCARREGAMENTO 
)
REFERENCES AGENDAMENTODEDESCARREGAMENTO
(
  ID 
)
ENABLE;
--NOTAFISCAL (FIM)


--PROCESSOCOTACAOITERACAOUSUARIO (INICIO)
CREATE TABLE PROCESSOCOTACAOITERACAOUSUARIO 
(
  IDFORNECEDORPARTICIPANTE NUMBER NOT NULL 
, VISUALIZADOPELOFORNECEDOR NUMBER(1, 0) NOT NULL 
, CONSTRAINT PK_PROCESSOCOTACAOITERUSUARIO PRIMARY KEY 
  (
    IDFORNECEDORPARTICIPANTE 
  )
  ENABLE 
);

ALTER TABLE PROCESSOCOTACAOITERACAOUSUARIO
ADD CONSTRAINT CHK_ITERACAO_VISUALIZADOFORNEC CHECK 
(VISUALIZADOPELOFORNECEDOR BETWEEN 0 AND 1)
ENABLE;


--PROCESSOCOTACAOITERACAOUSUARIO (FIM)

--CRIA��O DA TABELA MUNICIPIO (INICIO)
CREATE TABLE MUNICIPIO 
(
  CODIGO VARCHAR2(7 BYTE) NOT NULL 
, NOME VARCHAR2(50 CHAR) NOT NULL 
, UF VARCHAR2(2 BYTE) NOT NULL
, CONSTRAINT PK_MUNICIPIO PRIMARY KEY 
  (
    CODIGO 
  )
  ENABLE 
);

CREATE INDEX IDX_MUNICIPIO_NOME ON MUNICIPIO (NOME);
--CRIA��O DA TABELA MUNICIPIO (FIM)

--ALTERACAO NA TABELA PROCESSOCOTACAOFRETE (INICIO)
ALTER TABLE PROCESSOCOTACAOFRETE ADD "CADENCIA" NUMBER(13,3);
ALTER TABLE PROCESSOCOTACAOFRETE ADD "CLASSIFICACAO" NUMBER(1,0) DEFAULT 0;
ALTER TABLE PROCESSOCOTACAOFRETE ADD "CODIGOFORNECEDOR" VARCHAR2(10 BYTE);
ALTER TABLE PROCESSOCOTACAOFRETE ADD "CODIGOMUNICIPIOORIGEM" VARCHAR2(7 BYTE);
ALTER TABLE PROCESSOCOTACAOFRETE ADD "CODIGOMUNICIPIODESTINO" VARCHAR2(7 BYTE);
ALTER TABLE PROCESSOCOTACAOFRETE ADD CODIGODEPOSITO VARCHAR2(10 BYTE);

ALTER TABLE PROCESSOCOTACAOFRETE ADD CONSTRAINT "FK_COTACAOFRETE_FORNECEDOR" FOREIGN KEY ("CODIGOFORNECEDOR")
	  REFERENCES "FORNECEDOR" ("CODIGO") ENABLE;
ALTER TABLE PROCESSOCOTACAOFRETE ADD CONSTRAINT "FK_COTACAOFRETE_MUNDESTINO" FOREIGN KEY ("CODIGOMUNICIPIODESTINO")
	  REFERENCES "MUNICIPIO" ("CODIGO") ENABLE; 
ALTER TABLE PROCESSOCOTACAOFRETE ADD CONSTRAINT "FK_COTACAOFRETE_MUNORIGEM" FOREIGN KEY ("CODIGOMUNICIPIOORIGEM")
	  REFERENCES "MUNICIPIO" ("CODIGO") ENABLE;
	  
ALTER TABLE PROCESSOCOTACAOFRETE ADD CONSTRAINT "FK_COTACAOFRETE_DEPOSITO" FOREIGN KEY ("CODIGODEPOSITO")
	  REFERENCES "FORNECEDOR" ("CODIGO") ENABLE;
	  
UPDATE PROCESSOCOTACAOFRETE SET 
CADENCIA = 0
WHERE CADENCIA IS NULL;	  
	  
ALTER TABLE COTACAOFRETE ADD "CADENCIA" NUMBER(13,3);

UPDATE COTACAOFRETE SET CADENCIA = 0
WHERE EXISTS(
	SELECT 1
	FROM COTACAO C 
	WHERE COTACAOFRETE.ID = C.ID
	AND SELECIONADA = 1
)
AND CADENCIA IS NULL;

COMMIT;	  
	  
--ALTERACAO NA TABELA PROCESSOCOTACAOFRETE (FIM)	  

--CRIA�AO DA TABELA ORDEMDETRANSPORTE (INICIO)
CREATE TABLE ORDEMDETRANSPORTE 
(
  ID NUMBER NOT NULL 
, CODIGOFORNECEDOR VARCHAR2(10 BYTE) NOT NULL 
, IDPROCESSOCOTACAOFRETE NUMBER NOT NULL 
, QUANTIDADEADQUIRIDA NUMBER(13, 3) NOT NULL 
, QUANTIDADELIBERADA NUMBER(13, 3) NOT NULL 
, QUANTIDADECOLETADA NUMBER(13, 3) NOT NULL 
, QUANTIDADEREALIZADA NUMBER(13, 3) NOT NULL
, PRECOUNITARIO NUMBER(13, 2) NOT NULL
, QUANTIDADEDETOLERANCIA NUMBER(13, 3) NOT NULL
, CADENCIA NUMBER(13,3) NOT NULL
, CONSTRAINT PK_ORDEMDETRANSPORTE PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE ORDEMDETRANSPORTE
ADD CONSTRAINT FK_ORDEM_FORNECEDOR FOREIGN KEY
(
  CODIGOFORNECEDOR 
)
REFERENCES FORNECEDOR
(
  CODIGO 
)
ENABLE;

ALTER TABLE ORDEMDETRANSPORTE
ADD CONSTRAINT FK_ORDEM_PROCESSOCOTACAOFRETE FOREIGN KEY
(
  IDPROCESSOCOTACAOFRETE 
)
REFERENCES PROCESSOCOTACAOFRETE
(
  ID 
)
ENABLE;

CREATE SEQUENCE ORDEMDETRANSPORTE_ID_SEQUENCE  INCREMENT BY 1 START WITH 1;

--CRIA�AO DA TABELA ORDEMDETRANSPORTE (FIM)

--ALTERA��O DA TABELA FORNECEDOR (INICIO)
ALTER TABLE FORNECEDOR 
ADD (ENDERECO VARCHAR2(250 CHAR) );
--ALTERA��O DA TABELA FORNECEDOR (FIM)	  

ALTER TABLE USUARIOPERFIL 
DROP CONSTRAINT CHK_USUARIOPERFIL_PERFIL;

ALTER TABLE USUARIOPERFIL
ADD CONSTRAINT CHK_USUARIOPERFIL_PERFIL CHECK 
(PERFIL BETWEEN 1 AND 8)
ENABLE;

CREATE TABLE COLETA 
(
  ID NUMBER NOT NULL 
, REALIZADO NUMBER(1, 0) NOT NULL 
, PLACA VARCHAR2(8 CHAR) NOT NULL 
, MOTORISTA VARCHAR2(35 CHAR) NOT NULL 
, DATADACOLETA DATE NOT NULL 
, DATADEPREVISAODECHEGADA DATE NOT NULL 
, PESO NUMBER(13, 3) NOT NULL 
, VALORDOFRETE NUMBER(13, 2) NOT NULL 
, IDORDEMTRANSPORTE NUMBER NOT NULL 
, CONSTRAINT PK_COLETA PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE COLETA
ADD CONSTRAINT FK_COLETA_ORDEMTRANSPORTE FOREIGN KEY
(
  IDORDEMTRANSPORTE 
)
REFERENCES ORDEMDETRANSPORTE
(
  ID 
)
ENABLE;

CREATE SEQUENCE COLETA_ID_SEQUENCE  INCREMENT BY 1 START WITH 1;

CREATE TABLE NOTAFISCALDECOLETA 
(
  ID NUMBER NOT NULL 
, NUMERO VARCHAR2(9 BYTE) NOT NULL 
, SERIE VARCHAR2(3 CHAR) NOT NULL 
, NUMERODOCONHECIMENTO VARCHAR2(9 BYTE) NOT NULL
, DATAEMISSAO DATE NOT NULL 
, NUMEROCONTRATO VARCHAR2(20 CHAR) 
, PESO NUMBER(13, 3) NOT NULL 
, VALOR NUMBER(13, 2) NOT NULL 
, IDCOLETA NUMBER NOT NULL 
, CONSTRAINT PK_NOTAFISCALDECOLETA PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE NOTAFISCALDECOLETA
ADD CONSTRAINT FK_NOTA_COLETA FOREIGN KEY
(
  IDCOLETA 
)
REFERENCES COLETA
(
  ID 
)
ENABLE;

CREATE SEQUENCE NOTAFISCALDECOLETA_ID_SEQUENCE  INCREMENT BY 1 START WITH 1;


--cria��o da view (inicio)

CREATE VIEW AGENDAMENTODECARGAVISUALIZACAO AS
--DADOS DO AGENDAMENTO DE DESCARREGAMENTO
SELECT 'DESC' || IDQUOTA || AC.ID || NF.NUMERO AS ID, IDQUOTA, AC.ID AS IDAGENDAMENTO, NULL AS IDORDEMTRANSPORTE, NULL AS IDCOLETA, 'Soja' AS DESCRICAOMATERIAL, 'Descarregamento' AS DESCRICAOFLUXO, 
Q.DATA AS DATAAGENDAMENTO, PLACA,NF.NUMERO AS NUMERONF, CNPJEMITENTE, NOMEEMITENTE, AC.REALIZADO, Q.CODIGOTERMINAL, NULL AS CODIGODEPOSITO
FROM agendamentodedescarregamento AD INNER JOIN AGENDAMENTODECARGA AC ON AD.ID = AC.ID
INNER JOIN QUOTA Q ON AC.IDQUOTA = Q.ID
INNER JOIN notafiscal NF ON AD.ID = NF.IDAGENDAMENTODESCARREGAMENTO

UNION ALL

--DADOS DO AGENDAMENTO DE CARREGAMENTO
SELECT 'DESC' || IDQUOTA || AC.ID AS ID, IDQUOTA, AC.ID AS IDAGENDAMENTO, NULL AS IDORDEMTRANSPORTE, NULL AS IDCOLETA, 'Farelo' AS DESCRICAOMATERIAL, 'Carregamento' AS DESCRICAOFLUXO, 
Q.DATA AS DATAAGENDAMENTO, PLACA,NULL AS NUMERONF, NULL AS CNPJEMITENTE, NULL AS NOMEEMITENTE, AC.REALIZADO, Q.CODIGOTERMINAL, NULL AS CODIGODEPOSITO
FROM agendamentodecarregamento AD INNER JOIN AGENDAMENTODECARGA AC ON AD.ID = AC.ID
INNER JOIN QUOTA Q ON AC.IDQUOTA = Q.ID

UNION ALL

--DADOS DA COLETA
SELECT 'COLETA' || IDORDEMTRANSPORTE || C.ID || NFC.NUMERO AS ID, NULL AS IDQUOTA, NULL AS IDAGENDAMENTO, IDORDEMTRANSPORTE,C.ID AS IDCOLETA, P.DESCRICAO AS  DESCRICAOMATERIAL, 
'Descarregamento' AS DESCRICAOFLUXO, C.DATADEPREVISAODECHEGADA AS DATAAGENDAMENTO, C.PLACA, NFC.NUMERO AS NUMERONF,
FM.CNPJ AS CNPJEMITENTE, FM.NOME AS NOMEEMITENTE, C.REALIZADO,'1000' AS CODIGOTERMINAL,PF.CODIGODEPOSITO

FROM COLETA C INNER JOIN ORDEMDETRANSPORTE OT ON C.IDORDEMTRANSPORTE = OT.ID
INNER JOIN NOTAFISCALDECOLETA NFC ON NFC.IDCOLETA = C.ID
INNER JOIN PROCESSOCOTACAOFRETE PF ON OT.IDPROCESSOCOTACAOFRETE = PF.ID
INNER JOIN PROCESSOCOTACAO PC ON PF.ID = PC.ID
INNER JOIN PRODUTO P ON PC.CODIGOPRODUTO = P.CODIGO
LEFT JOIN FORNECEDOR FM ON PF.CODIGOFORNECEDOR = FM.CODIGO;



--cria��o da view (fim)
CREATE OR REPLACE PROCEDURE MONITORDEORDEMDETRANSPORTE (p_cursor OUT SYS_REFCURSOR, p_agrupamentos VARCHAR2, 
p_codigoMaterial Produto.Codigo%type, p_material Produto.Descricao%type,
p_codigoFornecedorDaMercadoria Fornecedor.Codigo%type, p_fornecedorDaMercadoria Fornecedor.Nome%type, 
p_codigoTransportadora Fornecedor.Codigo%type, p_transportadora Fornecedor.Nome%type, 
p_codigoDoMunicipioDeOrigem Municipio.Codigo%type,p_codigoDoMunicipioDeDestino Municipio.Codigo%type) AS

  v_query VARCHAR2(4000);
  v_subquery VARCHAR2(4000);
  v_agrupamentos VARCHAR2(4000):= 'GROUP BY Material';
  v_projecao VARCHAR2(4000):= 'SELECT sys_guid() || '''' as "Id", Material AS "Material"';
  v_projecaoDaSubQuery VARCHAR2(4000):= 'SELECT p.Descricao AS Material';
  v_from VARCHAR2(4000):= 'FROM ORDEMDETRANSPORTE ot ' ||
      'inner join ProcessoCotacaoFrete pcf on ot.IDPROCESSOCOTACAOFRETE=pcf.Id inner join ProcessoCotacao pc on pcf.Id=pc.Id ' ||
      'inner join Produto p on pc.CodigoProduto=p.Codigo ';
      
  v_where VARCHAR2(4000):= 'WHERE ot.QuantidadeLiberada - ot.QuantidadeColetada > 0';
  
BEGIN
  
  IF INSTR(p_agrupamentos, 'FornecedorDaMercadoria') > 0 OR p_fornecedorDaMercadoria IS NOT NULL THEN    

      v_from:= v_from || ' inner join Fornecedor FornecedorDaMercadoria ' ||
      'on pcf.CodigoFornecedor = FornecedorDaMercadoria.Codigo ';
      
  END IF;  
  
  IF INSTR(p_agrupamentos, 'Transportadora') > 0 OR p_transportadora IS NOT NULL THEN
      v_from:= v_from || 'inner join Fornecedor Transportadora ' ||
      'on ot.CodigoFornecedor = Transportadora.Codigo ';
  END IF;
  
  IF INSTR(p_agrupamentos, 'NumeroDoContrato') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', pcf.NumeroContrato';
      v_projecao:= v_projecao || ', NumeroContrato AS "NumeroDoContrato"';
      v_agrupamentos:= v_agrupamentos || ', NumeroContrato';
  ELSE
      v_projecao:= v_projecao || ', NULL AS "NumeroDoContrato"';
  END IF;

  IF INSTR(p_agrupamentos, 'FornecedorDaMercadoria') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', FornecedorDaMercadoria.Nome AS FornecedorDaMercadoria';
      v_projecao:= v_projecao || ', FornecedorDaMercadoria AS "FornecedorDaMercadoria"';
      v_agrupamentos:= v_agrupamentos || ', FornecedorDaMercadoria';
  ELSE
      v_projecao:= v_projecao || ', NULL AS "FornecedorDaMercadoria"';  
  END IF;
  
  IF INSTR(p_agrupamentos, 'Transportadora') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', Transportadora.Nome AS Transportadora';
      v_projecao:= v_projecao || ', Transportadora AS "Transportadora"';
      v_agrupamentos:= v_agrupamentos || ', Transportadora';
  ELSE
      v_projecao:= v_projecao || ', NULL AS "Transportadora"';  
  END IF;

  IF INSTR(p_agrupamentos, 'NumeroDaOrdemDeTransporte') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', TO_CHAR(ot.Id)AS NumeroDaOrdemDeTransporte';
      v_projecao:=  v_projecao || ', NumeroDaOrdemDeTransporte AS "NumeroDaOrdemDeTransporte"';
      v_agrupamentos:= v_agrupamentos || ', NumeroDaOrdemDeTransporte';
  ELSE
    v_projecao:=  v_projecao || ', NULL AS "NumeroDaOrdemDeTransporte"';
  END IF;
  
  IF INSTR(p_agrupamentos, 'MunicipioDeOrigem') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', MunicipioDeOrigem.Nome || ''/'' || MunicipioDeOrigem.UF AS MunicipioDeOrigem';
      v_projecao:= v_projecao || ', MunicipioDeOrigem AS "MunicipioDeOrigem"';
      v_from:= v_from || 
      'inner join Municipio MunicipioDeOrigem ' ||
      'on pcf.CodigoMunicipioOrigem = MunicipioDeOrigem.Codigo ';
      v_agrupamentos:= v_agrupamentos || ', MunicipioDeOrigem';
  ELSE
      v_projecao:= v_projecao || ', NULL AS "MunicipioDeOrigem"';
  END IF;
  
  IF INSTR(p_agrupamentos, 'MunicipioDeDestino') > 0 THEN
      v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', MunicipioDeDestino.Nome || ''/'' || MunicipioDeDestino.UF  AS MunicipioDeDestino';
      v_projecao:= v_projecao || ', MunicipioDeDestino AS "MunicipioDeDestino"';
      v_from:= v_from || 
      'inner join Municipio MunicipioDeDestino ' ||
      'on pcf.CodigoMunicipioDestino = MunicipioDeDestino.Codigo ';
      v_agrupamentos:= v_agrupamentos || ', MunicipioDeDestino';
  ELSE
      v_projecao:= v_projecao || ', NULL AS "MunicipioDeDestino"';
  END IF;
  
  --filtro por material
  IF p_codigoMaterial IS NOT NULL THEN
      v_where:= v_where || ' AND p.Codigo like ''%' || p_codigoMaterial || '%''';
  END IF;
  
  IF p_material IS NOT NULL THEN
      v_where:= v_where || ' AND LOWER(p.Descricao) like LOWER(''%' || p_material || '%'')';
  END IF;
  
  --filtro por fornecedor da mercadoria
  
  IF p_codigoFornecedorDaMercadoria IS NOT NULL THEN
      v_where:= v_where || ' AND pcf.CodigoFornecedor like ''%' || p_codigoFornecedorDaMercadoria || '%''';
  END IF;
  
  IF p_fornecedorDaMercadoria IS NOT NULL THEN

      v_where:= v_where || ' AND LOWER(FornecedorDaMercadoria.Nome) like LOWER(''%' || p_fornecedorDaMercadoria || '%'')';
      
  END IF;
  
  --filtro por transportadora
  IF p_codigoTransportadora IS NOT NULL THEN
      v_where:= v_where || ' AND ot.CodigoFornecedor like ''%' || p_codigoTransportadora || '%''';
  END IF;
  
  IF p_transportadora IS NOT NULL THEN
  
      v_where:= v_where || ' AND LOWER(Transportadora.Nome) like LOWER(''%' || p_transportadora || '%'')';
  
  END IF;
  
  --filtro por municipio de origem
  IF p_codigoDoMunicipioDeOrigem IS NOT NULL THEN
     v_where:= v_where || ' AND pcf.CodigoMunicipioOrigem = ''' || p_codigoDoMunicipioDeOrigem || '''';
  END IF;
  
  --filtro por destino
  IF p_codigoDoMunicipioDeDestino IS NOT NULL THEN
     v_where:= v_where || ' AND pcf.CodigoMunicipioDestino = ''' || p_codigoDoMunicipioDeDestino || '''';
  
  END IF;
  
  v_projecaoDaSubQuery:= v_projecaoDaSubQuery || ', ot.QuantidadeLiberada, ot.QuantidadeRealizada , ' || 
      'ot.QuantidadeColetada - ot.QuantidadeRealizada AS QuantidadeEmTransito,' ||
      'ot.QuantidadeLiberada - ot.QuantidadeColetada as QuantidadePendente,' ||
      'ot.QuantidadeColetada - ot.QuantidadeLiberada * ' ||
      '((CASE WHEN pcf.DataValidadeFinal < sysdate THEN pcf.DataValidadeFinal ELSE to_date(sysdate,''dd/mm/rrrr'') END - pcf.DataValidadeInicial) + 1) ' ||
      '/((pcf.DataValidadeFinal - pcf.DataValidadeInicial) + 1) AS SaldoProjetado, ' ||
      'COALESCE((SELECT sum(c.Peso) FROM Coleta c WHERE ot.Id = c.IdOrdemTransporte AND c.DataDePrevisaoDeChegada = to_date(sysdate,''dd/mm/rrrr'')),0) as PrevisaoDeChegadaNoDia ';
      
  v_projecao:= v_projecao || ', sum(QuantidadeLiberada) as "QuantidadeLiberada", ' || 
  'sum(QuantidadeRealizada) AS "QuantidadeRealizada", ' ||
  'round(sum(QuantidadePendente) * 100 / sum(QuantidadeLiberada),3) AS "PercentualPendente", ' ||
  'round(sum(SaldoProjetado) * 100 / sum(QuantidadeLiberada),3) As "PercentualProjetado", ' ||
  'sum(QuantidadeEmTransito) AS "QuantidadeEmTransito", ' ||
  'sum(QuantidadePendente) as "QuantidadePendente" , ' ||
  'sum(PrevisaoDeChegadaNoDia) as "PrevisaoDeChegadaNoDia" ';
      
  v_subquery:= v_projecaoDaSubQuery || v_from || v_where;
  
  v_query:= v_projecao ||
  ' FROM ( ' ||
    v_subquery ||
  ')' ||
  v_agrupamentos ||
  ' ORDER BY Material';
  
  --dbms_output.put_line(v_query);
  open p_cursor FOR v_query;

END;
/


--consultas que ainda precisam ser executadas em qas e produ��o, porque deviam ter sido criadas antes
UPDATE PROCESSOCOTACAOFRETE SET 
CADENCIA = 0
WHERE CADENCIA IS NULL;	  

COMMIT;



