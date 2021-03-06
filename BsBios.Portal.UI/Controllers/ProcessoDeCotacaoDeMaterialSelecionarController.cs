﻿using System;
using System.Web.Mvc;
using BsBios.Portal.Application.Services.Contracts;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class ProcessoDeCotacaoDeMaterialSelecionarController : Controller
    {
        private readonly IProcessoDeCotacaoDeMaterialSelecaoService _processoDeCotacaoSelecaoService;

        public ProcessoDeCotacaoDeMaterialSelecionarController(IProcessoDeCotacaoDeMaterialSelecaoService processoDeCotacaoSelecaoService)
        {
            _processoDeCotacaoSelecaoService = processoDeCotacaoSelecaoService;
        }

        [HttpPost]
        public ActionResult SelecionarCotacoes(ProcessoDeCotacaoDeMaterialSelecaoAtualizarVm processoDeCotacaoSelecaoAtualizarVm )
        {
            try
            {
                _processoDeCotacaoSelecaoService.AtualizarSelecao(processoDeCotacaoSelecaoAtualizarVm);
                return Json(new {Sucesso = true});
            }
            catch (Exception ex)
            {
                return Json(new {Sucesso = false, Mensagem = ex.Message});
            }
        }
    }
}