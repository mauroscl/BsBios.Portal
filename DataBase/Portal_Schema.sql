CREATE TABLE BSBIOS.USUARIO
  (
  Id NUMBER NOT NULL,
  Nome VARCHAR2 (80) NOT NULL,
  Login VARCHAR2 (20) NOT NULL,
  Senha VARCHAR2 (24) NOT NULL,
  Email VARCHAR2 (100) NOT NULL,
  Perfil INT NOT NULL
 )
/
COMMENT ON COLUMN BSBIOS.USUARIO.Id IS 'Chave da Tabela'
/
COMMENT ON COLUMN BSBIOS.USUARIO.Email IS 'E-mail utilizado para entrar em contato com o usu�rio'
/
COMMENT ON COLUMN BSBIOS.USUARIO.Perfil IS '1 - Comprador; 2 = Fornecedor'
/
ALTER TABLE BSBIOS.USUARIO ADD CONSTRAINT PK_USUARIO
  PRIMARY KEY (
  ID
)
 ENABLE 
 VALIDATE 
/
CREATE SEQUENCE BSBIOS.USUARIO_ID_SEQUENCE
 START WITH  1
 INCREMENT BY  1
 MINVALUE  1
/

INSERT INTO USUARIO
(Id, Nome, Login, Senha, Email)
SELECT usuario_id_sequence.NEXTVAL, 'Administrador Fusion', 'admfusion', 'nMt6vfHriwbmCFAim+R8qw==','mauro.leal@fusionconsultoria.com.br'
FROM DUAL
/
CREATE TABLE BSBIOS.MATERIAL
(
    Id NUMBER NOT NULL,
    CodigoSap VARCHAR2(18) NOT NULL,
    Descricao VARCHAR2(40) NOT NULL
)
/
ALTER TABLE BSBIOS.MATERIAL ADD CONSTRAINT PK_MATERIAL
  PRIMARY KEY (
  ID
)
 ENABLE 
 VALIDATE 
/
CREATE SEQUENCE BSBIOS.MATERIAL_ID_SEQUENCE
 START WITH  1
 INCREMENT BY  1
 MINVALUE  1
/
CREATE TABLE BSBIOS.FORNECEDOR
(
    Id NUMBER NOT NULL,
    CodigoSap VARCHAR2(10) NOT NULL,
    Nome VARCHAR2(35) NOT NULL
)
/
ALTER TABLE BSBIOS.FORNECEDOR ADD CONSTRAINT PK_FORNECEDOR
  PRIMARY KEY (
  ID
)
 ENABLE 
 VALIDATE 
/
CREATE SEQUENCE BSBIOS.FORNECEDOR_ID_SEQUENCE
 START WITH  1
 INCREMENT BY  1
 MINVALUE  1
/
