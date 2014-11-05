﻿using System;
using System.ComponentModel;

namespace BsBios.Portal.Common
{
    public class Enumeradores
    {
        public enum Perfil
        {
            [Description("Comprador Suprimentos")] 
            CompradorSuprimentos = 1,
            [Description("Comprador Logística")] 
            CompradorLogistica = 2,
            [Description("Fornecedor")] 
            Fornecedor = 3,
            [Description("Administrador")] 
            Administrador = 4,
            [Description("Gerenciador de Quotas")] 
            GerenciadorDeQuotas = 5,
            [Description("Agendador de Cargas")] 
            AgendadorDeCargas = 6,
            [Description("Conferidor de Cargas")] 
            ConferidorDeCargas = 7,
            [Description("Conferidor de Cargas em Depósito")] 
            ConferidorDeCargasEmDeposito = 8

        }

        public enum StatusProcessoCotacao
        {
            [Description("Não Iniciado")] 
            NaoIniciado = 1,
            [Description("Aberto")] 
            Aberto = 2,
            [Description("Fechado")]
            Fechado = 3,
            [Description("Cancelado")]
            Cancelado = 4
       }

        public enum StatusUsuario
        {
            Ativo = 1,
            Bloqueado = 2
        }

        public enum TipoDeCotacao
        {
            Material = 1,
            Frete = 2
        }

        public enum TipoDeImposto
        {
            Icms = 1,
            IcmsSubstituicao = 2,
            Ipi = 3,
            Pis = 4,
            Cofins = 5,
            PisCofins = 6
        }

        public enum FluxoDeCarga
        {
            Carregamento = 1,
            Descarregamento = 2
        }

        //public enum MaterialDeCarga
        //{
        //    Soja = 1,
        //    Farelo = 2
        //}

        public enum RealizacaoDeAgendamento
        {
            [Description("Não realizado")] 
            NaoRealizado = 0,
            Realizado = 1
        }

        public enum RelatorioDeAgendamento
        {
            ListagemDeQuotas = 1,
            ListagemDeAgendamentos = 2,
            PlanejadoVersusRealizado = 3,
            PlanejadoVersusRealizadoPorData = 4
        }

        public enum RelatorioDeProcessosDeCotacaoDeFrete
        {
            Analitico,
            SinteticoComSoma,
            SinteticoComMedia
        }

        public enum RelatorioDeOrdemDeTransporte
        {
            Resumido,
            Completo
        }

        public enum SelecaoDeFornecedores
        {
            [Description("Não selecionado")]
            NaoSelecionado,
            Selecionado,
            Todos
        }

        public enum EscolhaSimples
        {
            [Description("Não")]
            Nao = 0,
            Sim = 1,
            Todos = 2
        }

        public enum StatusDaOrdemDeTransporte
        {
            Pendente,
            Concluido
        }

        public enum StatusParaColeta
        {
            Aberto,
            Fechado
        }

        public enum RespostaDaCotacao
        {
            Pendente,
            Aceito,
            Recusado
        }

        public enum StatusDoConhecimentoDeTransporte
        {
            [Description("Não atribuido")]
            NaoAtribuido,
            Atribuido,
            Erro
        }

        public enum MotivoDeFechamentoDaOrdemDeTransporte
        {
            [Description("Negociação de Tarifa")]
            NegociacaoDeTarifa,
            [Description("Não cumprimento do Contrato")]
            NaoCumprimentoDoContrato,
            [Description("Alteração de local de coleta")]
            AlteracaoDeLocalDeColeta
        }

    }
}
