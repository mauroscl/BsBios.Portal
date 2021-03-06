﻿using System.Collections.Generic;
using System.Web.Mvc;
using BsBios.Portal.Common;
using BsBios.Portal.Infra.Queries.Contracts;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class RelatorioAgendamentoVisualizacaoController : Controller
    {
        private readonly IConsultaQuotaRelatorio _consultaQuotaRelatorio;

        public RelatorioAgendamentoVisualizacaoController(IConsultaQuotaRelatorio consultaQuotaRelatorio)
        {
            _consultaQuotaRelatorio = consultaQuotaRelatorio;
        }

        public ActionResult GerarRelatorio(Enumeradores.RelatorioDeAgendamento relatorioDeAgendamento, RelatorioAgendamentoFiltroVm filtro)
        {
            ViewBag.Filtro = filtro;
            ViewBag.RelatorioDeAgendamento = relatorioDeAgendamento;
            switch (relatorioDeAgendamento)
            {
                case Enumeradores.RelatorioDeAgendamento.ListagemDeQuotas:
                    ViewBag.TituloDoRelatorio = "Listagem de Quotas";
                    IList<QuotaCadastroVm> quotasListadas = _consultaQuotaRelatorio.ListagemDeQuotas(filtro);
                    return View("ListagemDeQuotas", quotasListadas);
                case Enumeradores.RelatorioDeAgendamento.ListagemDeAgendamentos:
                    ViewBag.TituloDoRelatorio = "Listagem de Agendamentos";
                    IList<AgendamentoDeCargaRelatorioListarVm> agendamentosListados = _consultaQuotaRelatorio.ListagemDeAgendamentos(filtro);
                    return View("ListagemDeAgendamentos", agendamentosListados);
                case Enumeradores.RelatorioDeAgendamento.PlanejadoVersusRealizado:
                    ViewBag.TituloDoRelatorio = "Agendamentos Planejado x Realizado";
                    IList<QuotaPlanejadoRealizadoVm> quotas = _consultaQuotaRelatorio.PlanejadoRealizado(filtro);
                    return View("PlanejadoRealizado", quotas);
                case Enumeradores.RelatorioDeAgendamento.PlanejadoVersusRealizadoPorData:
                    ViewBag.TituloDoRelatorio = "Agendamentos Planejado x Realizado por Data";
                    IList<QuotaPlanejadoRealizadoPorDataVm> quotasPorData = _consultaQuotaRelatorio.PlanejadoRealizadoPorData(filtro);
                    return View("PlanejadoRealizadoPorData", quotasPorData);
                default:
                    var contentResult = new ContentResult {Content = "Opção Inválida"};
                    return contentResult;
            }
        }

    }
}
