﻿using System;
using System.Web.Mvc;
using BsBios.Portal.Application.Services.Contracts;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class CotacaoDeMaterialAtualizarController : Controller
    {
        private readonly IAtualizadorDeCotacaoDeMaterial _atualizadorDeCotacao;

        public CotacaoDeMaterialAtualizarController(IAtualizadorDeCotacaoDeMaterial atualizadorDeCotacao)
        {
            _atualizadorDeCotacao = atualizadorDeCotacao;
        }

        [HttpPost]
        public JsonResult Salvar(CotacaoMaterialInformarVm cotacaoInformarVm)
        {
            try
            {
                _atualizadorDeCotacao.Atualizar(cotacaoInformarVm);
                return Json(new { Sucesso = true });
            }
            catch (Exception ex)
            {
                return Json(new { Sucesso = false, Mensagem = ex.Message });
            }

        }
    }
}