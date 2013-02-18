﻿using System;
using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Application.Services.Contracts;
using BsBios.Portal.Domain.Model;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Services.Implementations
{
    public class CadastroFornecedor: ICadastroFornecedor
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IFornecedores _fornecedores;

        public CadastroFornecedor(IUnitOfWork unitOfWork, IFornecedores fornecedores)
        {
            _unitOfWork = unitOfWork;
            _fornecedores = fornecedores;
        }

        public void Novo(FornecedorCadastroVm fornecedorCadastroVm)
        {
            try
            {
                _unitOfWork.BeginTransaction();
                var fornecedor = new Fornecedor(fornecedorCadastroVm.CodigoSap, fornecedorCadastroVm.Nome,fornecedorCadastroVm.Email);
                _fornecedores.Save(fornecedor);
                _unitOfWork.Commit();
            }
            catch (Exception)
            {
                _unitOfWork.RollBack();
                throw;
            }
        }

        private Fornecedor AtualizaFornecedor(FornecedorCadastroVm fornecedorCadastroVm)
        {
            Fornecedor fornecedor = _fornecedores.BuscaPeloCodigoSap(fornecedorCadastroVm.CodigoSap);

            if (fornecedor == null)
            {
                fornecedor = new Fornecedor(fornecedorCadastroVm.CodigoSap, fornecedorCadastroVm.Email, fornecedorCadastroVm.Nome);
            }
            else
            {
                fornecedor.Atualizar(fornecedorCadastroVm.Nome, fornecedorCadastroVm.Email);
            }

                             
            _fornecedores.Save(fornecedor);
            return fornecedor;
        }

        public IList<Fornecedor> AtualizarFornecedores(IList<FornecedorCadastroVm> fornecedores)
        {
            try
            {
                _unitOfWork.BeginTransaction();
                var retorno = fornecedores.Select(AtualizaFornecedor).ToList();
                _unitOfWork.Commit();
                return retorno;
            }
            catch (Exception)
            {
                _unitOfWork.RollBack();                
                throw;
            }
        }
    }
}
