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

--LABEL: GO LIVE DO AGENDAMENTO DE CARGAS

ALTER TABLE PROCESSOCOTACAO ADD (JUSTIFICATIVA CLOB );

--ALTERA��O NA TABELA REQUISICAOCOMPRA (INICIO)
ALTER TABLE REQUISICAOCOMPRA 
ADD (CODIGOGRUPODECOMPRA VARCHAR2(3 CHAR) );

ALTER TABLE REQUISICAOCOMPRA ADD MRP NUMBER(1,0);
ALTER TABLE REQUISICAOCOMPRA
ADD CONSTRAINT CHK_REQUISICAOCOMPRA_MRP CHECK 
(MRP BETWEEN 0 AND 1)
ENABLE;
UPDATE REQUISICAOCOMPRA SET MRP = 0;
ALTER TABLE REQUISICAOCOMPRA MODIFY MRP NUMBER(1,0) NOT NULL;
--ALTERA��O NA TABELA REQUISICAOCOMPRA (FIM)

--CRIA��O DA TABELA PROCESSODECOTACAOITEM (INICIO)
CREATE TABLE PROCESSOCOTACAOITEM 
(
  ID NUMBER NOT NULL 
, IDPROCESSOCOTACAO NUMBER NOT NULL
, CODIGOPRODUTO VARCHAR2(18 BYTE) NOT NULL
, QUANTIDADE NUMBER(13, 3)  NOT NULL
, CODIGOUNIDADEMEDIDA VARCHAR2(3 CHAR) NOT NULL
, CONSTRAINT PK_PROCESSODECOTACAOITEM PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE PROCESSOCOTACAOITEM
ADD CONSTRAINT ITEM_PROCESSOCOTACAO FOREIGN KEY
(
  IDPROCESSOCOTACAO 
)
REFERENCES PROCESSOCOTACAO
(
  ID 
)
ENABLE;

ALTER TABLE PROCESSOCOTACAOITEM
ADD CONSTRAINT ITEM_PRODUTO FOREIGN KEY
(
  CODIGOPRODUTO 
)
REFERENCES PRODUTO
(
  CODIGO 
)
ENABLE;

ALTER TABLE PROCESSOCOTACAOITEM
ADD CONSTRAINT ITEM_UNIDADEMEDIDA FOREIGN KEY
(
  CODIGOUNIDADEMEDIDA 
)
REFERENCES UNIDADEMEDIDA
(
  CODIGOINTERNO 
)
ENABLE;

CREATE SEQUENCE PROCESSOCOTACAOITEM_ID_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1;

--CRIA��O DA TABELA PROCESSODECOTACAOITEM (FIM)

--CRIA��O DA TABELA PROCESSODECOTACAOITEMFRETE (INICIO)

CREATE TABLE PROCESSOCOTACAOITEMFRETE 
(
  ID NUMBER NOT NULL 
, CONSTRAINT PK_PROCESSOCOTACAOITEMFRETE PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE PROCESSOCOTACAOITEMFRETE
ADD CONSTRAINT PROCESSOITEMFRETE_ITEM FOREIGN KEY
(
  ID 
)
REFERENCES PROCESSODECOTACAOITEM
(
  ID 
)
ENABLE;
--CRIA��O DA TABELA PROCESSOCOTACAOITEMFRETE (FIM)

--CRIA��O DA TABELA PROCESSODOTACAOITEMMATERIAL (INICIO)
CREATE TABLE PROCESSOCOTACAOITEMMATERIAL 
(
  ID NUMBER NOT NULL 
, IDREQUISICAOCOMPRA NUMBER NOT NULL 
, CONSTRAINT PK_PROCESSOCOTACAOITEMMATERIAL PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE PROCESSOCOTACAOITEMMATERIAL
ADD CONSTRAINT FK_PROCESSOITEMMATERIAL_ITEM FOREIGN KEY
(
  ID 
)
REFERENCES PROCESSOCOTACAOITEM
(
  ID 
)
ENABLE;

ALTER TABLE PROCESSOCOTACAOITEMMATERIAL
ADD CONSTRAINT FK_PROCESSOITEMMAT_REQUISICAO FOREIGN KEY
(
  IDREQUISICAOCOMPRA 
)
REFERENCES REQUISICAOCOMPRA
(
  ID 
)
ENABLE;
--CRIA��O DA TABELA PROCESSOCOTACAOITEMMATERIAL (FIM)

--IMPORTA��O DOS DADOS DA TABELA DE PROCESSO DE COTA��O PARA A TABELA DE ITENS (INICIO)
INSERT INTO PROCESSOCOTACAOITEM
(id,idprocessocotacao, codigoproduto, quantidade, codigounidademedida)
select processocotacaoitem_id_seq.nextval,pc.id, codigoproduto, quantidade, codigounidademedida
from processocotacao pc;

INSERT INTO PROCESSOCOTACAOITEMFRETE
(id)
select id
from processocotacaoitem
where id in (select id from processocotacaofrete);


INSERT INTO PROCESSOCOTACAOITEMMATERIAL
(id, idrequisicaocompra)
select item.id, pcm.idrequisicaocompra
from processocotacaoitem item inner join processocotacaomaterial pcm
on item.idprocessocotacao = pcm.id
--IMPORTA��O DOS DADOS DA TABELA DE PROCESSO DE COTA��O PARA A TABELA DE ITENS (FIM)

