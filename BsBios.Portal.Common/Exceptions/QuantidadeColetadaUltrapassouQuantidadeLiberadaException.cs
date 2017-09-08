﻿using System;

namespace BsBios.Portal.Common.Exceptions
{
    public class QuantidadeColetadaUltrapassouQuantidadeLiberadaException: Exception
    {
        private readonly decimal _quantidadeColetada;
        private readonly decimal _quantidadeLiberada;

        public QuantidadeColetadaUltrapassouQuantidadeLiberadaException(decimal quantidadeColetada, decimal quantidadeLiberada)
        {
            _quantidadeColetada = quantidadeColetada;
            _quantidadeLiberada = quantidadeLiberada;
        }

        public override string Message
        {
            get { return "Não é possível salvar a Coleta porque a quantidade total coletada na Ordem de Transporte (" + 
                _quantidadeColetada.ToString(Constantes.FormatoDeCampoDeQuantidade) + ") ultrapassou a quantidade liberada (" +
                _quantidadeLiberada.ToString(Constantes.FormatoDeCampoDeQuantidade) + "), já considerando a tolerância.";
            }
        }
    }
}