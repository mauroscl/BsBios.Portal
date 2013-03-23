﻿using System;
using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Application.Queries.Builders;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Queries.Implementations
{
    public class ConsultaQuota : IConsultaQuota
    {
        private readonly IQuotas _quotas;
        private readonly IBuilder<Quota, QuotaConsultarVm> _builderQuota;
        private readonly IBuilder<Quota, QuotaPorFornecedorVm> _builderQuotaPorFornecedor;

        public ConsultaQuota(IQuotas quotas, IBuilder<Quota, QuotaConsultarVm> builderQuota, 
            IBuilder<Quota, QuotaPorFornecedorVm> builderQuotaPorFornecedor)
        {
            _quotas = quotas;
            _builderQuota = builderQuota;
            _builderQuotaPorFornecedor = builderQuotaPorFornecedor;
        }

        public bool PossuiQuotaNaData(DateTime data)
        {
            return _quotas.FiltraPorData(data).Count() > 0;
        }

        public IList<QuotaConsultarVm> QuotasDaData(DateTime data)
        {
            return _builderQuota.BuildList(_quotas.FiltraPorData(data).List());
        }

        public KendoGridVm ListarQuotasDoFornecedor(PaginacaoVm paginacaoVm, string codigoDoFornecedor)
        {
            _quotas.DoFornecedor(codigoDoFornecedor);
            return new KendoGridVm
                {
                    QuantidadeDeRegistros = _quotas.Count() ,
                    Registros = _builderQuotaPorFornecedor.BuildList(_quotas
                    .GetQuery()
                    .OrderByDescending(x => x.Data)
                    .Skip(paginacaoVm.Skip)
                    .Take(paginacaoVm.Take).ToList())
                            .Cast<ListagemVm>()
                            .ToList()
                             
                };
        }
    }
}