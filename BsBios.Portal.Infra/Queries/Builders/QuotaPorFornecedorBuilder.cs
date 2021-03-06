using BsBios.Portal.Common;
using BsBios.Portal.Domain.Entities;
using BsBios.Portal.Domain.Services.Contracts;
using BsBios.Portal.ViewModel;

namespace BsBios.Portal.Infra.Queries.Builders
{
    public class QuotaPorFornecedorBuilder:BuilderMulti<Quota, Usuario, QuotaPorFornecedorVm>
    {
        private readonly IVerificaPermissaoAgendamento _verificaPermissaoAgendamento;

        public QuotaPorFornecedorBuilder(IVerificaPermissaoAgendamento verificaPermissaoAgendamento)
        {
            _verificaPermissaoAgendamento = verificaPermissaoAgendamento;
        }

        public override QuotaPorFornecedorVm BuildSingle(Quota model, Usuario usuario)
        {
            return new QuotaPorFornecedorVm
                {
                    IdQuota = model.Id,
                    //CodigoTerminal =  model.CodigoTerminal,
                    //CodigoFornecedor = model.Fornecedor.Codigo,
                    Data = model.Data.ToShortDateString(),
                    //CodigoMaterial =  (int) model.Material,
                    DescricaoMaterial = model.Material.Descricao(),
                    CodigoFluxoDeCarga = (int) model.FluxoDeCarga,
                    FluxoDeCarga = model.FluxoDeCarga.Descricao(),
                    PesoTotal = model.PesoTotal  ,
                    PesoAgendado = model.PesoAgendado ,
                    PesoDisponivel = model.PesoDisponivel,
                    PermiteAdicionar = _verificaPermissaoAgendamento.PermiteAdicionar(model,usuario )
                };
        }
    }
}
