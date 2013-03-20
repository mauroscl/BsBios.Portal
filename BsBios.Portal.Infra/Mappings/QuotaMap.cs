﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BsBios.Portal.Common;
using BsBios.Portal.Domain.Entities;
using FluentNHibernate.Mapping;

namespace BsBios.Portal.Infra.Mappings
{
    public class QuotaMap: ClassMap<Quota>
    {
        public QuotaMap()
        {
            Table("Quota");
            CompositeId()
                .KeyProperty(x => x.Data)
                .KeyProperty(x => x.Terminal, "CodigoTerminal")
                .KeyProperty(x => x.FluxoDeCarga).CustomType<Enumeradores.FluxoDeCarga>()
                .KeyReference(x => x.Transportadora, "CodigoTransportadora");

            Map(x => x.Peso);
        }
    }
}
