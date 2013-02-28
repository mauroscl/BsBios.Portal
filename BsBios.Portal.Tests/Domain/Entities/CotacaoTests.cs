﻿using System;
using System.Linq;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Tests.DefaultProvider;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BsBios.Portal.Tests.Domain.Entities
{
    [TestClass]
    public class CotacaoTests
    {
        [TestMethod]
        public void QuandoAbroUmProcessoDeCotacaoACotacaoEhCriadaCorretamenteCorretamente()
        {
            ProcessoDeCotacaoDeMaterial processoDeCotacao = DefaultObjects.ObtemProcessoDeCotacaoDeMaterialPadrao();
            Fornecedor fornecedor = DefaultObjects.ObtemFornecedorPadrao();
            processoDeCotacao.Atualizar(DateTime.Today.AddDays(10));
            processoDeCotacao.AdicionarFornecedor(fornecedor);
            processoDeCotacao.Abrir();

            Cotacao cotacao = processoDeCotacao.Cotacoes.First();

            Assert.AreEqual(fornecedor.Codigo, cotacao.Fornecedor.Codigo);
            Assert.IsFalse(cotacao.Selecionada);
            Assert.IsNull(cotacao.ValorUnitario);
            Assert.IsNull(cotacao.Iva);
            Assert.IsNull(cotacao.QuantidadeAdquirida);
            Assert.IsNull(cotacao.Incoterm);
            Assert.IsNull(cotacao.DescricaoIncoterm);
            Assert.IsNull(cotacao.CondicaoDePagamento);
        }

        [TestMethod]
        public void QuandoAtualizarUmaCotacaoAsPropriedadesSaoAtualizadas()
        {
            ProcessoDeCotacaoDeMaterial processoDeCotacao = DefaultObjects.ObtemProcessoDeCotacaoDeMaterialPadrao();
            Fornecedor fornecedor = DefaultObjects.ObtemFornecedorPadrao();
            processoDeCotacao.Atualizar(DateTime.Today.AddDays(10));
            processoDeCotacao.AdicionarFornecedor(fornecedor);
            processoDeCotacao.Abrir();
            Incoterm incoterm = DefaultObjects.ObtemIncotermPadrao();
            processoDeCotacao.AtualizarCotacao(fornecedor.Codigo,new decimal( 150.20) ,incoterm, "Descrição do Incoterm");

            Cotacao cotacao = processoDeCotacao.Cotacoes.First();
            Assert.IsNotNull(cotacao);
            Assert.AreEqual(new decimal(150.20), cotacao.ValorUnitario);
            Assert.AreEqual("001", cotacao.Incoterm.Codigo);
            Assert.AreEqual("Descrição do Incoterm", cotacao.DescricaoIncoterm);

        }

        [TestMethod]
        public void QuandoSelecionaUmFornecedorACotacaoFicaMarcadaComoSelecionadaQuantidadeAdquiridaCondicaoPagamentoIvaSaoPreenchidos()
        {
            ProcessoDeCotacaoDeMaterial processoDeCotacao = DefaultObjects.ObtemProcessoDeCotacaoDeMaterialPadrao();
            Fornecedor fornecedor = DefaultObjects.ObtemFornecedorPadrao();
            processoDeCotacao.Atualizar(DateTime.Today.AddDays(10));
            processoDeCotacao.AdicionarFornecedor(fornecedor);
            processoDeCotacao.Abrir();
            Incoterm incoterm = DefaultObjects.ObtemIncotermPadrao();
            processoDeCotacao.AtualizarCotacao(fornecedor.Codigo, new decimal(150.20), incoterm, "Descrição do Incoterm");
            Iva iva = DefaultObjects.ObtemIvaPadrao();
            CondicaoDePagamento condicaoDePagamento = DefaultObjects.ObtemCondicaoDePagamentoPadrao();
            processoDeCotacao.SelecionarCotacao(fornecedor.Codigo, new decimal(120.00), iva, condicaoDePagamento);

            Cotacao cotacao = processoDeCotacao.Cotacoes.First();

            Assert.IsTrue(cotacao.Selecionada);
            Assert.AreEqual(new decimal(120.00), cotacao.QuantidadeAdquirida);
            Assert.AreEqual("01", cotacao.Iva.Codigo);
            Assert.AreEqual("C001",cotacao.CondicaoDePagamento.Codigo);

        }

        
    }
}