﻿using System.Collections.Generic;
using System.Web.Mvc;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Infra.Model;
using BsBios.Portal.UI.Controllers;
using BsBios.Portal.ViewModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using StructureMap;

namespace BsBios.Portal.Tests.UI.Controllers
{
    [TestClass]
    public class CotacaoTests
    {
        private readonly CotacaoMaterialController _controller;
        private static readonly UsuarioConectado UsuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
        private readonly Mock<IConsultaCotacaoDoFornecedor> _consultaCotacaoDoFornecedorMock;
        private readonly Mock<IConsultaCondicaoPagamento> _consultaCondicaoPagamentoMock;
        private readonly Mock<IConsultaIncoterm> _consultaIncotermsMock;

        public CotacaoTests()
        {
            _consultaCotacaoDoFornecedorMock = new Mock<IConsultaCotacaoDoFornecedor>(MockBehavior.Strict);
            _consultaCotacaoDoFornecedorMock.Setup(x => x.ConsultarCotacaoDeMaterial(It.IsAny<int>(), It.IsAny<string>()))
                .Returns(new CotacaoMaterialCadastroVm());

            _consultaCondicaoPagamentoMock = new Mock<IConsultaCondicaoPagamento>(MockBehavior.Strict);
            _consultaCondicaoPagamentoMock.Setup(x => x.ListarTodas())
                .Returns(new List<CondicaoDePagamentoCadastroVm>());

            _consultaIncotermsMock = new Mock<IConsultaIncoterm>(MockBehavior.Strict);
            _consultaIncotermsMock.Setup(x => x.ListarTodos())
                .Returns(new List<IncotermCadastroVm>());

            _controller = new CotacaoMaterialController(_consultaCotacaoDoFornecedorMock.Object,
                _consultaCondicaoPagamentoMock.Object, _consultaIncotermsMock.Object);
        }

        [TestMethod]
        public void QuandoEditarACotacaoRetornaAViewCorretaComModelo()
        {
            ViewResult viewResult = _controller.EditarCadastro(10);
            Assert.AreEqual("Cadastro", viewResult.ViewName);
            Assert.IsInstanceOfType(viewResult.Model, typeof(CotacaoMaterialCadastroVm));

            _consultaCotacaoDoFornecedorMock.Verify(x => x.ConsultarCotacaoDeMaterial(It.IsAny<int>(), It.IsAny<string>()), Times.Once());

        }

        [TestMethod]
        public void QuandoEditarACotacaoRealizaAConsultaPassandoOUsuarioLogado()
        {
            _consultaCotacaoDoFornecedorMock.Setup(x => x.ConsultarCotacaoDeMaterial(It.IsAny<int>(), It.IsAny<string>()))
                .Returns(new CotacaoMaterialCadastroVm())
                .Callback((int idProcessoCotacao, string login) => Assert.AreEqual(UsuarioConectado.Login, login));

            _controller.EditarCadastro(10);
        }
    }
}
