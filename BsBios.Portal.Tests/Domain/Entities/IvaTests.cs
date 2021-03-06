﻿using BsBios.Portal.Domain.Entities;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BsBios.Portal.Tests.Domain.Entities
{
    [TestClass]
    public class IvaTests
    {
        [TestMethod]
        public void QuandoCrioUmIvaConsigoAcessarAsPropriedades()
        {
            var iva = new Iva("01", "IVA 01");
            Assert.AreEqual("01", iva.Codigo);
            Assert.AreEqual("IVA 01", iva.Descricao);
        }

        [TestMethod]
        public void QuandoAlteroADescricaoDoIvaAPropriedadeFicaComONovoValor()
        {
            var iva = new Iva("01", "IVA 01");
            iva.AtualizaDescricao("IVA 01 atualizado");
            Assert.AreEqual("IVA 01 atualizado", iva.Descricao);
        }
    }

}
