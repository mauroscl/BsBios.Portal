﻿using System.Collections.Generic;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Services.Contracts
{
    public interface ICadastroIva
    {
        //void Novo(IvaCadastroVm ivaCadastroVm);
        void AtualizarIvas(IList<IvaCadastroVm> ivas);
    }
}