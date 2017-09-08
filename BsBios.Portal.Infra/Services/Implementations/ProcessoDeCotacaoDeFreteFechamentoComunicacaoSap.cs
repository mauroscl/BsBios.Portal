﻿using System.Linq;
using BsBios.Portal.Common;
using BsBios.Portal.Common.Exceptions;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Services.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Infra.Services.Implementations
{
    public class ProcessoDeCotacaoDeFreteFechamentoComunicacaoSap : IProcessoDeCotacaoDeFreteFechamentoComunicacaoSap
    {
        private readonly IComunicacaoSap<ListaProcessoDeCotacaoDeFreteFechamento> _comunicacaoSap;

        public ProcessoDeCotacaoDeFreteFechamentoComunicacaoSap(IComunicacaoSap<ListaProcessoDeCotacaoDeFreteFechamento> comunicacaoSap)
        {
            _comunicacaoSap = comunicacaoSap;
        }

        public ApiResponseMessage EfetuarComunicacao(ProcessoDeCotacaoDeFrete processo)
        {
            ProcessoDeCotacaoItem item = processo.Itens.First();
            if (item.Produto.NaoEstocavel)
            {
                //Cotações de frete para empresas do grupo que não utilizam o SAP deverão ser realizadas com material NLAG 
                //(Material não estocável). Para este tipo de material a cotação não deverá ser enviada para o SAP;
                return new ApiResponseMessage
                {
                    Retorno = new Retorno
                    {
                        Codigo = "200",
                        Texto = "S"
                    }
                };
            }

            if (processo.FornecedoresSelecionados.Count == 0)
            {
                throw new ProcessoDeCotacaoFecharSemCotacaoSelecionadaException();
            }

            var mensagemParaEnviar = new ListaProcessoDeCotacaoDeFreteFechamento();

            var processoDeCotacaoDeFrete = (ProcessoDeCotacaoDeFrete)processo.CastEntity();

            foreach (var fornecedorParticipante in processoDeCotacaoDeFrete.FornecedoresParticipantes)
            {
                if (fornecedorParticipante.Cotacao != null && fornecedorParticipante.Cotacao.Itens.First().Selecionada)
                {
                    CotacaoItem itemDaCotacao = fornecedorParticipante.Cotacao.Itens.First();
                    mensagemParaEnviar.Add(new ProcessoDeCotacaoDeFreteFechamentoComunicacaoSapVm
                    {
                        NumeroDoProcessoDeCotacao = processoDeCotacaoDeFrete.Id,
                        CodigoTransportadora = fornecedorParticipante.Fornecedor.Codigo,
                        //CodigoMaterial = processoAuxiliar.Produto.Codigo,
                        CodigoMaterial = item.Produto.Codigo,
                        //CodigoUnidadeMedida = processoAuxiliar.UnidadeDeMedida.CodigoInterno,
                        CodigoUnidadeMedida = item.UnidadeDeMedida.CodigoInterno,
                        CodigoItinerario = processo.Itinerario.Codigo,
                        DataDeValidadeInicial = processo.DataDeValidadeInicial.ToString("yyyyMMdd"),
                        DataDeValidaFinal = processo.DataDeValidadeFinal.ToString("yyyyMMdd"),
                        NumeroDoContrato = processo.NumeroDoContrato ?? "",
                        Valor = itemDaCotacao.ValorComImpostos
                    });
                }
            }

            ApiResponseMessage apiResponseMessage =
                _comunicacaoSap.EnviarMensagem(
                    "/HttpAdapter/HttpMessageServlet?senderParty=PORTAL&senderService=HTTP&interfaceNamespace=http://portal.bsbios.com.br/&interface=si_cotacaoFreteFechamento_portal&qos=be"
                    , mensagemParaEnviar);
            if (apiResponseMessage.Retorno.Codigo == "E")
            {
                throw new ComunicacaoSapException("json", "Ocorreu um erro ao comunicar o fechamento do Processo de Cotação de Frete para o SAP. Detalhes: " + apiResponseMessage.Retorno.Texto);
            }
            return apiResponseMessage;

        }
    }
}