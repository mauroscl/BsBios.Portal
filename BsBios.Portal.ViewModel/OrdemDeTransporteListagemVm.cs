﻿namespace BsBios.Portal.ViewModel
{
    public class OrdemDeTransporteListagemVm:ListagemVm
    {
        public int Id { get; set; }
        public string Material { get; set; }
        public string CodigoDoFornecedor { get; set; }
        public string NomeDoFornecedor { get; set; }
        public decimal QuantidadeColetada { get; set; }
        public decimal QuantidadeLiberada { get; set; }
        public decimal QuantidadeRealizada { get; set; }
    }
}