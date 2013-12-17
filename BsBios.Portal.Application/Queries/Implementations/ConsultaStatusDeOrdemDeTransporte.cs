﻿using System;
using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Application.Queries.Builders;
using BsBios.Portal.Application.Queries.Contracts;
using BsBios.Portal.Common;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Application.Queries.Implementations
{
    public class ConsultaStatusDeOrdemDeTransporte : IConsultaStatusDeOrdemDeTransporte
    {

        private readonly IBuilder<Enumeradores.StatusDaOrdemDeTransporte, ChaveValorVm> _builder;

        public ConsultaStatusDeOrdemDeTransporte(IBuilder<Enumeradores.StatusDaOrdemDeTransporte, ChaveValorVm> builder)
        {
            _builder = builder;
        }

        public IList<ChaveValorVm> Listar()
        {
            var status = Enum.GetValues(typeof(Enumeradores.StatusDaOrdemDeTransporte)).Cast<Enumeradores.StatusDaOrdemDeTransporte>().ToList();

            return _builder.BuildList(status);
        }
    }
}