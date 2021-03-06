﻿using BsBios.Portal.Domain.Entities;
using FluentNHibernate.Mapping;

namespace BsBios.Portal.Infra.Mappings
{
    public class FornecedorParticipanteMap: ClassMap<FornecedorParticipante>
    {
        public FornecedorParticipanteMap()
        {
            Table("FornecedorParticipante");
            Id(x => x.Id).GeneratedBy.Sequence("FORNECPARTICIPANTE_ID_SEQUENCE");

            Map(x => x.NumeroDaCotacao, "NumeroCotacao");

            References(x => x.ProcessoDeCotacao).Column("IdProcessoCotacao");
            References(x => x.Fornecedor).Column("CodigoFornecedor");
            //HasOne(x => x.Cotacao)/*.PropertyRef("FornecedorParticipante")*/
            //    .Cascade.All();
            References(x => x.Cotacao)
                .Column("IdCotacao")
                .Nullable()
                .Insert()
                .Update()
                .Cascade.All();
        }
    }
}
