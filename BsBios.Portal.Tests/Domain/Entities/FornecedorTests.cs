﻿using BsBios.Portal.Domain.Entities;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BsBios.Portal.Tests.Domain.Entities
{
    [TestClass]
    public class FornecedorTests
    {
        [TestMethod]
        public void QuandoCrioUmFornecedorConsigoAcessarAsPropriedades()
        {
            var fornecedor = new Fornecedor("FORNEC0001", "FORNECEDOR 0001", "fornecedor@empresa.com.br", "cnpj", "municipio", "uf", false, "Endereco 0001");
            Assert.AreEqual("FORNEC0001", fornecedor.Codigo);
            Assert.AreEqual("FORNECEDOR 0001", fornecedor.Nome);
            Assert.AreEqual("fornecedor@empresa.com.br",fornecedor.Email);
            Assert.AreEqual("cnpj", fornecedor.Cnpj);
            Assert.AreEqual("municipio", fornecedor.Municipio);
            Assert.AreEqual("uf", fornecedor.Uf);
            Assert.IsFalse(fornecedor.Transportadora);
            Assert.AreEqual( "Endereco 0001",  fornecedor.Endereco);
        }

        [TestMethod]
        public void QuandoAlterarUmFornecedorConsigoAcessarOsNovosValores()
        {
            var fornecedor = new Fornecedor("FORNEC0001", "FORNECEDOR 0001", "fornecedor@empresa.com.br", "cnpj", "municipio", "uf", false, "endereço");
            fornecedor.Atualizar("NOVO FORNECEDOR 0001", "novofornecedor@empresa.com.br", "novocnpj", "novo municipio", "nova uf", true, "novo endereço");
            Assert.AreEqual("NOVO FORNECEDOR 0001", fornecedor.Nome);
            Assert.AreEqual("novofornecedor@empresa.com.br",fornecedor.Email);
            Assert.AreEqual("novocnpj", fornecedor.Cnpj);
            Assert.AreEqual("novo municipio", fornecedor.Municipio);
            Assert.AreEqual("nova uf", fornecedor.Uf);
            Assert.IsTrue(fornecedor.Transportadora);
            Assert.AreEqual("novo endereço", fornecedor.Endereco);
        }
    }
}
