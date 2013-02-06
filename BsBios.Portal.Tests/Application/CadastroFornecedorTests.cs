﻿using System;
using BsBios.Portal.ApplicationServices.Contracts;
using BsBios.Portal.ApplicationServices.Implementation;
using BsBios.Portal.Common.Exceptions;
using BsBios.Portal.Domain.Model;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.Tests.Common;
using BsBios.Portal.Tests.DefaultProvider;
using BsBios.Portal.ViewModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace BsBios.Portal.Tests.Application
{
    [TestClass]
    public class CadastroFornecedorTests
    {
        private readonly Mock<IUnitOfWorkNh> _unitOfWorkNhMock;
        private readonly Mock<IFornecedores> _fornecedoresMock; 
        private readonly FornecedorCadastroVm _fornecedorCadastroVm;
        private readonly ICadastroFornecedor _cadastroFornecedor;
         
        public CadastroFornecedorTests()
        {
            _unitOfWorkNhMock = DefaultRepository.GetDefaultMockUnitOfWork();
            _fornecedoresMock = new Mock<IFornecedores>(MockBehavior.Strict);
            _fornecedoresMock.Setup(x => x.Save(It.IsAny<Fornecedor>()));
            _cadastroFornecedor = new CadastroFornecedor(_unitOfWorkNhMock.Object, _fornecedoresMock.Object);

            _fornecedorCadastroVm = new FornecedorCadastroVm()
                {
                    CodigoSap = "FORNEC0001",
                    Nome = "FORNECEDOR 0001"
                };
        }

        [TestMethod]
        public void QuandoCadastroUmNovoFornecedorERealizadaPersistencia()
        {
            _cadastroFornecedor.Novo(_fornecedorCadastroVm);
            _fornecedoresMock.Verify(x => x.Save(It.IsAny<Fornecedor>()),Times.Once());
        }
        [TestMethod]
        public void QuandoCadastroUmNovoFornecedorComSucessoERealizadoCommit()
        {
            _cadastroFornecedor.Novo(_fornecedorCadastroVm);
            _unitOfWorkNhMock.Verify(x => x.BeginTransaction(), Times.Once());
            _unitOfWorkNhMock.Verify(x => x.Commit(),Times.Once());
            _unitOfWorkNhMock.Verify(x =>x.RollBack(), Times.Never());
        }
        [TestMethod]
        public void QuandoOcorreAlgumaExcecaoEhRealizadoRollback()
        {
            _fornecedoresMock.Setup(x => x.Save(It.IsAny<Fornecedor>()))
                             .Throws(new ExcecaoDeTeste("Ocorreu um erro ao cadastrar o Fornecedor"));

            try
            {
                _cadastroFornecedor.Novo(_fornecedorCadastroVm);
                Assert.Fail("Deveria ter gerado excessão");
            }
            catch (ExcecaoDeTeste)
            {
                _unitOfWorkNhMock.Verify(x => x.BeginTransaction(), Times.Once());
                _unitOfWorkNhMock.Verify(x => x.RollBack(), Times.Once());
                _unitOfWorkNhMock.Verify(x => x.Commit(), Times.Never());
            }


        }
    }
}
