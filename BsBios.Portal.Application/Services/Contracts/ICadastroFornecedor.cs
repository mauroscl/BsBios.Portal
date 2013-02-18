﻿using System.Collections.Generic;
using BsBios.Portal.Domain.Model;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Services.Contracts
{
    public interface ICadastroFornecedor
    {
        void Novo(FornecedorCadastroVm fornecedorCadastroVm);
        IList<Fornecedor> AtualizarFornecedores(IList<FornecedorCadastroVm> fornecedores);
    }
}