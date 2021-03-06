using System.Collections.Generic;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Infra.Queries.Builders;
using BsBios.Portal.Infra.Queries.Contracts;
using BsBios.Portal.Infra.Repositories.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Infra.Queries.Implementations
{
    public class ConsultaCondicaoPagamento: IConsultaCondicaoPagamento
    {
        private readonly ICondicoesDePagamento _condicoesDePagamento;
        private readonly IBuilder<CondicaoDePagamento, CondicaoDePagamentoCadastroVm> _builder;

        public ConsultaCondicaoPagamento(ICondicoesDePagamento condicoesDePagamento, IBuilder<CondicaoDePagamento, CondicaoDePagamentoCadastroVm> builder)
        {
            _condicoesDePagamento = condicoesDePagamento;
            _builder = builder;
        }

        public IList<CondicaoDePagamentoCadastroVm> Listar(PaginacaoVm paginacaoVm, CondicaoDePagamentoCadastroVm filtro)
        {
            if (!string.IsNullOrEmpty(filtro.Codigo))
            {
                _condicoesDePagamento.BuscaPeloCodigo(filtro.Codigo);

            }

            if (!string.IsNullOrEmpty(filtro.Descricao))
            {
                _condicoesDePagamento.FiltraPelaDescricao(filtro.Descricao);
            }
            int skip = (paginacaoVm.Page - 1) * paginacaoVm.PageSize;

            //paginacaoVm.TotalRecords = _condicoesDePagamento.Count();

            return _builder.BuildList(_condicoesDePagamento.Skip(skip).Take(paginacaoVm.Take).List());
            
        }

        public IList<CondicaoDePagamentoCadastroVm> ListarTodas()
        {
            return _builder.BuildList(_condicoesDePagamento.List());
        }
    }
}
