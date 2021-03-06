using System.Linq;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Queries.Builders;
using BsBios.Portal.Infra.Queries.Contracts;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Infra.Queries.Implementations
{
    public class ConsultaItinerario: IConsultaItinerario
    {
        private readonly IItinerarios _itinerarios;
        private readonly IBuilder<Itinerario, ItinerarioCadastroVm> _builder;


        public ConsultaItinerario(IItinerarios itinerarios, IBuilder<Itinerario, ItinerarioCadastroVm> builder)
        {
            _itinerarios = itinerarios;
            _builder = builder;
        }

        public KendoGridVm Listar(PaginacaoVm paginacaoVm, ItinerarioFiltroVm filtro)
        {
            _itinerarios.CodigoContendo(filtro.Codigo);
            _itinerarios.DescricaoContendo(filtro.Local1);
            _itinerarios.DescricaoContendo(filtro.Local2);

            var kendoGridVmn = new KendoGridVm()
            {
                QuantidadeDeRegistros = _itinerarios.Count(),
                Registros =
                    _builder.BuildList(_itinerarios.Skip(paginacaoVm.Skip).Take(paginacaoVm.Take).List())
                            .Cast<ListagemVm>()
                            .ToList()

            };
            return kendoGridVmn;
        }

    }
}
