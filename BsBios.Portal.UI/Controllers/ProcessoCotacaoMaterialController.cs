﻿using System;
using System.Collections.Generic;
using System.Web.Mvc;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Infra.Model;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;
using StructureMap;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class ProcessoCotacaoMaterialController : Controller
    {
        private readonly IConsultaProcessoDeCotacaoDeMaterial _consultaProcessoDeCotacaoDeMaterial;
        private readonly IConsultaIva _consultaIva;

        public ProcessoCotacaoMaterialController(IConsultaProcessoDeCotacaoDeMaterial consultaProcessoDeCotacaoDeMaterial, IConsultaIva consultaIva)
        {
            _consultaProcessoDeCotacaoDeMaterial = consultaProcessoDeCotacaoDeMaterial;
            _consultaIva = consultaIva;
        }


        [HttpGet]
        public ActionResult Index()
        {
            var usuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
            if (usuarioConectado.Perfil == (int) Common.Enumeradores.Perfil.Comprador)
            {
                ViewData["ActionEdicao"] = Url.Action("EditarCadastro","ProcessoCotacaoMaterial");

            }
            if (usuarioConectado.Perfil == (int) Common.Enumeradores.Perfil.Fornecedor)
            {
                ViewData["ActionEdicao"] = Url.Action("EditarCadastro", "Cotacao");
            }

            return View();
        }
        [HttpGet]
        public JsonResult Listar(PaginacaoVm paginacaoVm)
        {
            var usuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
            var filtro = new ProcessoCotacaoMaterialFiltroVm();
            if (usuarioConectado.Perfil == (int) Common.Enumeradores.Perfil.Fornecedor)
            {
                filtro.CodigoFornecedor = usuarioConectado.Login;
            }

            var kendoGridVm = _consultaProcessoDeCotacaoDeMaterial.Listar(paginacaoVm, filtro);
            return Json(new { registros = kendoGridVm.Registros, totalCount = kendoGridVm.QuantidadeDeRegistros }, JsonRequestBehavior.AllowGet);
        }

        public ViewResult EditarCadastro(int idProcessoCotacao)
        {
            try
            {
                ProcessoCotacaoMaterialCadastroVm cadastro = _consultaProcessoDeCotacaoDeMaterial.ConsultaProcesso(idProcessoCotacao);
                return View("Cadastro", cadastro);
            }
            catch (Exception ex)
            {
                ViewData["erro"] = ex.Message;
                return View("Cadastro");
            }
        }

        [HttpGet]
        public JsonResult ListarFornecedores(int idProcessoCotacao)
        {
            var kendoGridVm = _consultaProcessoDeCotacaoDeMaterial.FornecedoresParticipantes(idProcessoCotacao);
            return Json(kendoGridVm, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SelecionarFornecedores(int idProcessoCotacao, string codigoProduto)
        {
            ViewData["CodigoProduto"] = codigoProduto;
            ViewData["IdProcessoCotacao"] = idProcessoCotacao; 
            return PartialView("_SelecionarFornecedor");
        }

        public PartialViewResult SelecionarCotacoes(int idProcessoCotacao)
        {
            try
            {
                ViewData["IdProcessoCotacao"] = idProcessoCotacao;
                return PartialView("_SelecionarCotacao");

            }
            catch (Exception ex)
            {
                ViewData["IdProcessoCotacao"] = idProcessoCotacao;
                ViewData["erro"] = ex.Message;
                return PartialView("_SelecionarCotacao");
            }
        }

        [HttpGet]
        public JsonResult ListarCotacoes(int idProcessoCotacao)
        {
            IList<CotacaoSelecionarVm> cotacoes = _consultaProcessoDeCotacaoDeMaterial.CotacoesDosFornecedores(idProcessoCotacao);
            return Json(new {Registros = cotacoes}, JsonRequestBehavior.AllowGet);
        }

    }
}
