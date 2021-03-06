﻿using System;
using BsBios.Portal.Application.Services.Contracts;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.Infra.Services.Contracts;

namespace BsBios.Portal.Application.Services.Implementations
{
    public class FechamentoDeProcessoDeCotacaoDeFreteService: IFechamentoDeProcessoDeCotacaoDeFreteService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IProcessosDeCotacao _processosDeCotacao;
        private readonly IGeradorDeEmailDeFechamentoDeProcessoDeCotacao _geradorDeEmail;
        private readonly IProcessoDeCotacaoComunicacaoSap _comunicacaoSap;

        public FechamentoDeProcessoDeCotacaoDeFreteService(IUnitOfWork unitOfWork, IProcessosDeCotacao processosDeCotacao,
            IGeradorDeEmailDeFechamentoDeProcessoDeCotacao geradorDeEmail,
            IProcessoDeCotacaoComunicacaoSap comunicacaoSap)
        {
            _unitOfWork = unitOfWork;
            _processosDeCotacao = processosDeCotacao;
            _geradorDeEmail = geradorDeEmail;
            _comunicacaoSap = comunicacaoSap;
        }

        public void Executar(int idProcessoCotacao)
        {
            try
            {
                _unitOfWork.BeginTransaction();

                ProcessoDeCotacao processoDeCotacao = _processosDeCotacao.BuscaPorId(idProcessoCotacao).Single();
                processoDeCotacao.Fechar();
                _comunicacaoSap.EfetuarComunicacao(processoDeCotacao);
                _geradorDeEmail.GerarEmail(processoDeCotacao);
                _processosDeCotacao.Save(processoDeCotacao);

                _unitOfWork.Commit();
            }
            catch (Exception)
            {
                _unitOfWork.RollBack();
                throw;
            }
        }
    }
   
}
