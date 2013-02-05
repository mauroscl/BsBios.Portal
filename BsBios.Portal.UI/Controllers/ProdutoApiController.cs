﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BsBios.Portal.ApplicationServices.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.UI.Controllers
{
    public class ProdutoApiController : ApiController
    {
        private readonly ICadastroProduto _cadastroProduto;

        public ProdutoApiController(ICadastroProduto cadastroProduto)
        {
            _cadastroProduto = cadastroProduto;
        }

        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]ProdutoCadastroVm produtoCadastroVm)
        {
            try
            {
                _cadastroProduto.Novo(produtoCadastroVm);
                return Request.CreateResponse(HttpStatusCode.OK);

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.Message);
            }
        }

    }
}