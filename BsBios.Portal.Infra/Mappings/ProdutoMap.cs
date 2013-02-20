﻿using BsBios.Portal.Domain.Model;
using FluentNHibernate.Mapping;
using NHibernate.Mapping;
//using NHibernate.Mapping.ByCode;

namespace BsBios.Portal.Infra.Mappings
{
    public class ProdutoMap: ClassMap<Produto>
    {
        public ProdutoMap()
        {
            Table("Produto");
            Id(x => x.Codigo);
            Map(x => x.Descricao);
            Map(x => x.Tipo);
            HasManyToMany(x => x.Fornecedores)
                .Cascade.All()
                .Table("ProdutoFornecedor").ParentKeyColumn("CodigoProduto").ChildKeyColumn("CodigoFornecedor");
            //Bag(x => x. , collectionMapping =>
            //{
            //    collectionMapping.Table("TagPosts");
            //    collectionMapping.Cascade(Cascade.None);
            //    collectionMapping.Key(k => k.Column("TagID"));
            //},
            //                map => map.ManyToMany(p => p.Column("PostID")));
        }
    }
}
