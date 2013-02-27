﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Domain.ValueObjects;

namespace BsBios.Portal.Tests.DefaultProvider
{
    public static class DefaultObjects
    {
        public static RequisicaoDeCompra ObtemRequisicaoDeCompraPadrao()
        {
            var usuarioCriador = new Usuario("Usuario Criador", "criador", null, Enumeradores.Perfil.Comprador);
            var fornecedorPretendido = new Fornecedor("fpret", "Fornecedor Pretendido", null);
            var material = new Produto("MAT0001", "MATERIAL DE COMPRA", "T01");

            var dataDeRemessa = DateTime.Today.AddDays(-2);
            var dataDeLiberacao = DateTime.Today.AddDays(-1);
            var dataDeSolicitacao = DateTime.Today;

            var requisicaoDeCompra = new RequisicaoDeCompra(usuarioCriador, "requisitante", fornecedorPretendido,
                dataDeRemessa, dataDeLiberacao, dataDeSolicitacao, "C001", "UNT", 1000,
                material, "Requisição de Compra enviada pelo SAP", "00001", "REQ0001");
            
            return requisicaoDeCompra;
        }

        public static RequisicaoDeCompra ObtemRequisicaoDeCompraSemRequisitanteEFornecedor()
        {
            var usuarioCriador = new Usuario("Usuario Criador", "criador", null, Enumeradores.Perfil.Comprador);
            var material = new Produto("MAT0001", "MATERIAL DE COMPRA", "T01");

            var dataDeRemessa = DateTime.Today.AddDays(-2);
            var dataDeLiberacao = DateTime.Today.AddDays(-1);
            var dataDeSolicitacao = DateTime.Today;

            var requisicaoDeCompra = new RequisicaoDeCompra(usuarioCriador, null, null,
                dataDeRemessa, dataDeLiberacao, dataDeSolicitacao, "C001", "UNT", 1000,
                material, "Requisição de Compra enviada pelo SAP", "00001", "REQ0001");

            return requisicaoDeCompra;
        }


        public static ProcessoDeCotacaoDeMaterial ObtemProcessoDeCotacaoDeMaterialPadrao()
        {
            var requisicaoDeCompra = ObtemRequisicaoDeCompraPadrao();
            var processoDeCotacao = new ProcessoDeCotacaoDeMaterial(requisicaoDeCompra, requisicaoDeCompra.Material, 100);
            return processoDeCotacao;
        }

        public static ProcessoDeCotacaoDeMaterial ObtemProcessoDeCotacaoAbertoPadrao()
        {
            ProcessoDeCotacaoDeMaterial processoDeCotacao = ObtemProcessoDeCotacaoDeMaterialPadrao();
            Fornecedor fornecedor = ObtemFornecedorPadrao();
            processoDeCotacao.Atualizar(DateTime.Today.AddDays(10));
            processoDeCotacao.AdicionarFornecedor(fornecedor);
            processoDeCotacao.Abrir();
            return processoDeCotacao;
        }

        public static ProcessoDeCotacaoDeMaterial ObtemProcessoDeCotacaoDeMaterialFechado()
        {
            ProcessoDeCotacaoDeMaterial processoDeCotacao = ObtemProcessoDeCotacaoAbertoPadrao();
            processoDeCotacao.AtualizarCotacao("FORNEC0001",125, ObtemIncotermPadrao(),"Descrição do Incotem");
            processoDeCotacao.SelecionarCotacao("FORNEC0001", 100, ObtemIvaPadrao(), ObtemCondicaoDePagamentoPadrao());
            processoDeCotacao.Fechar();
            return processoDeCotacao;
        }

        public static Fornecedor ObtemFornecedorPadrao()
        {
            var fornecedor = new Fornecedor("FORNEC0001", "FORNECEDOR 001", "fornecedor0001@empresa.com.br");
            return fornecedor;
        }

        public static Usuario ObtemUsuarioPadrao()
        {
            var usuario = new Usuario("Usuario 0001", "usuario0001", "usuario0001@empresa.com.br",
                                      Enumeradores.Perfil.Comprador);
            return usuario;
        }

        public static Produto ObtemProdutoPadrao()
        {
            var produto = new Produto("PROD0001", "PRODUTO 0001", "01");
            return produto;
        }

        public static Incoterm ObtemIncotermPadrao()
        {
            return new Incoterm("001", "INCOTERM 001");
        }

        public static Iva ObtemIvaPadrao()
        {
            return new Iva("01", "IVA 01");
        }

        public static CondicaoDePagamento ObtemCondicaoDePagamentoPadrao()
        {
            return new CondicaoDePagamento("C001", "CONDIÇÃO 001");
        }
    }
}
