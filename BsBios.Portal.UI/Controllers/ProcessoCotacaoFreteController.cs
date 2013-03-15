﻿using System;
using System.Web.Mvc;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Common;
using BsBios.Portal.Infra.Model;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;
using StructureMap;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class ProcessoCotacaoFreteController : Controller
    {
        private readonly IConsultaUnidadeDeMedida _consultaUnidadeDeMedida ;
        private readonly IConsultaProcessoDeCotacaoDeMaterial _consultaProcessoDeCotacaoDeMaterial;
        private readonly IConsultaProcessoDeCotacaoDeFrete _consultaProcessoDeCotacaoDeFrete;

        public ProcessoCotacaoFreteController(IConsultaUnidadeDeMedida consultaUnidadeDeMedida, IConsultaProcessoDeCotacaoDeMaterial consultaProcessoDeCotacaoDeMaterial, IConsultaProcessoDeCotacaoDeFrete consultaProcessoDeCotacaoDeFrete)
        {
            _consultaUnidadeDeMedida = consultaUnidadeDeMedida;
            _consultaProcessoDeCotacaoDeMaterial = consultaProcessoDeCotacaoDeMaterial;
            _consultaProcessoDeCotacaoDeFrete = consultaProcessoDeCotacaoDeFrete;
        }

        //
        // GET: /CotacaoFrete/

        [HttpGet]
        public ActionResult Index()
        {
            var usuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
            if (usuarioConectado.Perfis.Contains(Enumeradores.Perfil.CompradorLogistica))
            {
                ViewData["ActionEdicao"] = Url.Action("EditarCadastro", "ProcessoCotacaoFrete");
            }
            if (usuarioConectado.Perfis.Contains(Enumeradores.Perfil.Fornecedor))
            {
                ViewData["ActionEdicao"] = Url.Action("EditarCadastro", "Cotacao");
            }

            ViewData["ActionListagem"] = Url.Action("Listar", "ProcessoCotacaoFrete");
            ViewBag.TituloDaPagina = "Cotações de Frete";
            return View("_ProcessoCotacaoIndex");
        }
        [HttpGet]
        public JsonResult Listar(PaginacaoVm paginacaoVm)
        {
            var usuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
            var filtro = new ProcessoCotacaoMaterialFiltroVm()
            {
                TipoDeCotacao = (int)Enumeradores.TipoDeCotacao.Frete
            };
            if (usuarioConectado.Perfis.Contains(Enumeradores.Perfil.Fornecedor))
            {
                filtro.CodigoFornecedor = usuarioConectado.Login;
            }

            var kendoGridVm = _consultaProcessoDeCotacaoDeMaterial.Listar(paginacaoVm, filtro);
            return Json(new { registros = kendoGridVm.Registros, totalCount = kendoGridVm.QuantidadeDeRegistros }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ViewResult NovoCadastro()
        {
            ViewBag.UnidadesDeMedida = _consultaUnidadeDeMedida.ListarTodos();
            
            return View("Cadastro");
        }

        [HttpGet]
        public ViewResult EditarCadastro(int idProcessoCotacao)
        {
            try
            {
                ProcessoCotacaoFreteCadastroVm cadastro = _consultaProcessoDeCotacaoDeFrete.ConsultaProcesso(idProcessoCotacao);
                ViewBag.UnidadesDeMedida = _consultaUnidadeDeMedida.ListarTodos();
                
                return View("Cadastro", cadastro);

            }
            catch (Exception ex)
            {
                ViewData["erro"] = ex.Message;
                return View("Cadastro");
            }

        }

        public ActionResult SelecionarProduto(ProdutoCadastroVm produtoCadastroVm)
        {
            return PartialView("_SelecionarProduto", produtoCadastroVm);
        }

        public ActionResult SelecionarItinerario(ItinerarioCadastroVm itinerarioCadastroVm)
        {
            return View("_SelecionarItinerario", itinerarioCadastroVm);
        }
    }
}
