﻿using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Domain.Repositories;
using BsBios.Portal.Domain.ValueObjects;
using BsBios.Portal.Infra.Queries.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Infra.Queries.Implementations
{
    public class ConsultaMunicipio : IConsultaMunicipio
    {
        private readonly IMunicipios _municipios;

        public ConsultaMunicipio(IMunicipios municipios)
        {
            _municipios = municipios;
        }

        public IList<AutoCompleteVm> NomeComecandoCom(string nome)
        {
            _municipios.NomeComecandoCom(nome);

            //return (from municipio in _municipios.GetQuery()
            //    select new AutoCompleteVm
            //    {
            //        Codigo = municipio.Codigo,
            //        label = municipio.ToString(),
            //        value = municipio.ToString(),
            //    }).ToList();

            IList<Municipio> municipiosSelecionados = _municipios.List();

            return municipiosSelecionados.Select(x => new AutoCompleteVm
            {
                Codigo = x.Codigo,
                label = x.ToString(),
                value = x.ToString()
            }).ToList();


        }
    }
}