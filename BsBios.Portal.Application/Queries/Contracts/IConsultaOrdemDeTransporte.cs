﻿using System.Collections.Generic;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Queries.Contracts
{
    public interface IConsultaOrdemDeTransporte
    {
        KendoGridVm Listar(PaginacaoVm paginacao, OrdemDeTransporteListagemFiltroVm filtro);
        OrdemDeTransporteCadastroVm ConsultarOrdem(int id);

        KendoGridVm ListarColetas(PaginacaoVm paginacao, int idDaOrdemDeTransporte);

        ColetaVm ConsultaColeta(int idDaOrdemDeTransporte, int idDaColeta);

        IList<NotaFiscalDeColetaVm> NotasFiscaisDaColeta(int iddDaOrdemDeTransporte, int idColeta);
    }
}