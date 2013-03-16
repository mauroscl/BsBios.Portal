﻿using System.Web.Mvc;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Infra.Model;
using BsBios.Portal.UI.Filters;
using BsBios.Portal.ViewModel;
using StructureMap;

namespace BsBios.Portal.UI.Controllers
{
    [SecurityFilter]
    public class CotacaoMaterialController : Controller
    {
        private readonly IConsultaCotacaoDoFornecedor _consultaCotacaoDoFornecedor;
        private readonly IConsultaCondicaoPagamento _consultaCondicaoPagamento;
        private readonly IConsultaIncoterm _consultaIncoterms;
        
        public CotacaoMaterialController(IConsultaCotacaoDoFornecedor consultaCotacaoDoFornecedor, IConsultaCondicaoPagamento consultaCondicaoPagamento, IConsultaIncoterm consultaIncoterms)
        {
            _consultaCotacaoDoFornecedor = consultaCotacaoDoFornecedor;
            _consultaCondicaoPagamento = consultaCondicaoPagamento;
            _consultaIncoterms = consultaIncoterms;
        }

        [HttpGet]
        public ViewResult EditarCadastro(int idProcessoCotacao)
        {
            ViewBag.Incoterms = _consultaIncoterms.ListarTodos();
            ViewBag.CondicoesDePagamento = _consultaCondicaoPagamento.ListarTodas();

            var usuarioConectado = ObjectFactory.GetInstance<UsuarioConectado>();
            CotacaoMaterialCadastroVm viewModel = _consultaCotacaoDoFornecedor.ConsultarCotacaoDeMaterial(idProcessoCotacao, usuarioConectado.Login);
            return View("Cadastro",viewModel);
        }


    }
}
