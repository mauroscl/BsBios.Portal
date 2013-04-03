﻿using System;
using System.Web.Mvc;
using BsBios.Portal.Application.Services.Contracts;

namespace BsBios.Portal.UI.Controllers
{
    public class ProcessoDeCotacaoDeMaterialFechamentoController : Controller
    {
        private readonly IFechamentoDeProcessoDeCotacaoService _service;

        public ProcessoDeCotacaoDeMaterialFechamentoController(IFechamentoDeProcessoDeCotacaoServiceFactory serviceFactory)
        {
            _service = serviceFactory.Construir();
        }

        [HttpPost]
        public JsonResult AbrirProcesso(int idProcessoCotacao)
        {
            try
            {
                _service.Executar(idProcessoCotacao);
                return Json(new { Sucesso = true, Mensagem = "O Processo de Cotação foi fechado com sucesso." });
            }
            catch (Exception ex)
            {
                return Json(new { Sucesso = false, Mensagem = "Ocorreu um erro ao fechar o Processo de Cotação. Detalhes: " + ex.Message });
            }
        }
    }
    
}