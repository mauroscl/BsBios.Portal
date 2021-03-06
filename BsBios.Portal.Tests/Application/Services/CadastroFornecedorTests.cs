﻿using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Application.Services.Contracts;
using BsBios.Portal.Application.Services.Implementations;
using BsBios.Portal.Common;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.Tests.Common;
using BsBios.Portal.ViewModel;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;

namespace BsBios.Portal.Tests.Application.Services
{
    [TestClass]
    public class CadastroFornecedorTests
    {
        private readonly Mock<IUnitOfWork> _unitOfWorkMock;
        private readonly Mock<IFornecedores> _fornecedoresMock;
        private readonly Mock<IUsuarios> _usuariosMock; 
        private readonly FornecedorCadastroVm _fornecedorCadastroVm;
        private readonly ICadastroFornecedor _cadastroFornecedor;
        private readonly IList<Fornecedor> _fornecedoresRepositorio;
        private readonly IList<Usuario> _usuariosRepositorio;
         
        public CadastroFornecedorTests()
        {
            _unitOfWorkMock = CommonMocks.DefaultUnitOfWorkMock();
            _fornecedoresRepositorio = new List<Fornecedor>();

            _fornecedoresMock = new Mock<IFornecedores>(MockBehavior.Strict);
            _fornecedoresMock.Setup(x => x.Save(It.IsAny<Fornecedor>())).Callback((Fornecedor fornecedor) => Assert.IsNotNull(fornecedor));
            _fornecedoresMock.Setup(x => x.BuscaListaPorCodigo(It.IsAny<string[]>()))
                .Callback((string[] codigos) =>
                    {
                        if (codigos.Contains("FORNEC0001"))
                        {
                            _fornecedoresRepositorio.Add(new FornecedorParaAtualizacao("FORNEC0001", "FORNECEDOR 0001", "fornecedor@empresa.com.br","cnpj alterado", "municipio alterado", "uf alterada", false));
                        }
                    })
                .Returns(_fornecedoresMock.Object);

            _fornecedoresMock.Setup(x => x.List()).Returns(_fornecedoresRepositorio);

            _usuariosRepositorio = new List<Usuario>();
            _usuariosMock = new Mock<IUsuarios>(MockBehavior.Strict);
            _usuariosMock.Setup(x => x.FiltraPorListaDeLogins(It.IsAny<string[]>()))
                         .Callback((string[] logins) =>
                         {
                             if (logins.Contains("FORNEC0001"))
                             {
                                 _usuariosRepositorio.Add(new UsuarioParaAtualizacao("FORNEC0001", "FORNECEDOR 0001", "fornecedor@empresa.com.br"));
                             }
                         })
                         .Returns(_usuariosMock.Object);
            _usuariosMock.Setup(x => x.List())
                         .Returns(_usuariosRepositorio);

            _usuariosMock.Setup(x => x.Save(It.IsAny<Usuario>()));

            _cadastroFornecedor = new CadastroFornecedor(_unitOfWorkMock.Object, _fornecedoresMock.Object, _usuariosMock.Object);

            _fornecedorCadastroVm = new FornecedorCadastroVm()
                {
                    Codigo = "FORNEC0001",
                    Nome = "FORNECEDOR 0001",
                    Email = "fornecedor@empresa.com.br"
                };
        }

        [TestMethod]
        public void QuandoCadastroUmNovoFornecedorERealizadaPersistencia()
        {
            _cadastroFornecedor.Novo(_fornecedorCadastroVm);
            _fornecedoresMock.Verify(x => x.Save(It.IsAny<Fornecedor>()),Times.Once());
            CommonVerifications.VerificaCommitDeTransacao(_unitOfWorkMock);
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
                CommonVerifications.VerificaRollBackDeTransacao(_unitOfWorkMock);
            }
        }

        [TestMethod]
        public void QuandoReceberUmFornecedorExistenteDeveAtualizar()
        {

            _fornecedoresMock.Setup(x => x.Save(It.IsAny<Fornecedor>())).Callback((Fornecedor fornecedor) =>
                {
                    Assert.IsNotNull(fornecedor);
                    Assert.IsInstanceOfType(fornecedor, typeof(FornecedorParaAtualizacao));
                    Assert.AreEqual("FORNEC0001", fornecedor.Codigo);
                    Assert.AreEqual("FORNECEDOR 0001 ATUALIZADO", fornecedor.Nome);
                    Assert.AreEqual("emailatualizado@empresa.com.br",fornecedor.Email);
                    Assert.AreEqual("cnpj alterado", fornecedor.Cnpj);
                    Assert.AreEqual("municipio alterado", fornecedor.Municipio);
                    Assert.AreEqual("uf", fornecedor.Uf);
                    Assert.IsTrue(fornecedor.Transportadora);
                });
            _cadastroFornecedor.AtualizarFornecedores(new List<FornecedorCadastroVm>()
                {
                    new FornecedorCadastroVm()
                        {
                            Codigo ="FORNEC0001" ,
                            Nome = "FORNECEDOR 0001 ATUALIZADO" ,
                            Email = "emailatualizado@empresa.com.br",
                            Cnpj = "cnpj alterado" ,
                            Municipio = "municipio alterado" ,
                            Uf = "uf",
                            Transportadora = "X"

                        }
                });

        }
        [TestMethod]
        public void QuandoReceberUmFornecedorNovoDeveAdicionar()
        {
            _fornecedoresMock.Setup(x => x.Save(It.IsAny<Fornecedor>())).Callback((Fornecedor fornecedor) =>
            {
                Assert.IsNotNull(fornecedor);
                Assert.IsNotInstanceOfType(fornecedor, typeof(FornecedorParaAtualizacao));
                Assert.AreEqual("FORNEC0002", fornecedor.Codigo);
                Assert.AreEqual("FORNECEDOR 0002", fornecedor.Nome);
                Assert.AreEqual("fornecedor0002@empresa.com.br", fornecedor.Email);
                Assert.AreEqual("cnpj", fornecedor.Cnpj);
                Assert.AreEqual("municipio", fornecedor.Municipio);
                Assert.AreEqual("uf", fornecedor.Uf);
                Assert.IsTrue(fornecedor.Transportadora);
            });

            _cadastroFornecedor.AtualizarFornecedores(new List<FornecedorCadastroVm>()
                {
                    new FornecedorCadastroVm()
                        {
                            Codigo = "FORNEC0002" ,
                            Nome =  "FORNECEDOR 0002",
                            Email = "fornecedor0002@empresa.com.br",
                            Cnpj = "cnpj" ,
                            Municipio = "municipio" ,
                            Uf = "uf",
                            Transportadora = "X"
                        }
                });

        }
        [TestMethod]
        public void QuandoCadastrarUmNovoFornecedorTemQueCriarUmUsuarioParaOFornecedorComPerfilFornecedor()
        {

            _usuariosMock.Setup(x => x.Save(It.IsAny<Usuario>()))
                         .Callback((Usuario usuario) =>
                             {
                                 Assert.IsNotNull(usuario);
                                 Assert.AreEqual("FORNEC0002", usuario.Login);
                                 Assert.AreEqual("FORNECEDOR 0002", usuario.Nome);
                                 Assert.AreEqual("fornecedor0002@empresa.com.br", usuario.Email);
                                 Assert.AreEqual(1,usuario.Perfis.Count(x => x == Enumeradores.Perfil.Fornecedor ));

                                 _unitOfWorkMock.Verify(x => x.BeginTransaction(), Times.Once());
                                 _unitOfWorkMock.Verify(x => x.Commit(), Times.Never());

                             });

            _cadastroFornecedor.AtualizarFornecedores(new List<FornecedorCadastroVm>()
                {
                    new FornecedorCadastroVm()
                        {
                            Codigo = "FORNEC0002" ,
                            Nome =  "FORNECEDOR 0002",
                            Email = "fornecedor0002@empresa.com.br",
                            Cnpj = "cnpj" ,
                            Municipio = "municipio" ,
                            Uf = "uf",
                            Transportadora = "X"
                        }
                });

            _usuariosMock.Verify(x => x.Save(It.IsAny<Usuario>()), Times.Once());

            
        }

        [TestMethod]
        public void QuandoAlteraUmFornecedorUsuarioDoFornecedorTambemEAlterado()
        {
            _usuariosMock.Setup(x => x.Save(It.IsAny<Usuario>()))
                         .Callback((Usuario usuario) =>
                             {
                                 Assert.IsNotNull(usuario);
                                 Assert.AreEqual("FORNECEDOR 0001 ATUALIZADO", usuario.Nome);
                                 Assert.AreEqual("emailatualizado@empresa.com.br", usuario.Email);
                             });
            _cadastroFornecedor.AtualizarFornecedores(new List<FornecedorCadastroVm>()
                {
                    new FornecedorCadastroVm()
                        {
                            Codigo ="FORNEC0001" ,
                            Nome = "FORNECEDOR 0001 ATUALIZADO" ,
                            Email = "emailatualizado@empresa.com.br",
                            Cnpj = "9897948000156",
                            Municipio = "Porto Alegre",
                            Uf = "RS",
                            Transportadora = "X"
                        }
                });

            _usuariosMock.Verify(x => x.Save(It.IsAny<Usuario>()), Times.Once());
            
        }

    }

    public class FornecedorParaAtualizacao: Fornecedor
    {
        public FornecedorParaAtualizacao(string codigo, string nome, string email, string cnpj, string municipio, string uf, bool transportadora) 
            : base(codigo, nome, email,cnpj, municipio, uf,transportadora)
        {
        }
    }

}
