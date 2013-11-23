﻿using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BsBios.Portal.ViewModel
{
    public class ColetaVm: ColetaListagemVm
    {

        [DisplayName("Valor do Frete")]
        public decimal ValorDoFrete { get; set; }

        public NotaFiscalDeColetaVm NotaFiscal { get; set; }
        //public bool PermiteEditar { get; set; }
        public bool PermiteRealizar { get; set; }
        
        [DisplayName("Unidade de Medida")]
        public string UnidadeDeMedida { get; set; }

        [DisplayName("Preço Unitário")]
        public decimal PrecoUnitario { get; set; }

        [DisplayName("Número do Contrato")]
        public string NumeroDoContrato { get; set; }

        [DisplayName("CNPJ do Emitente")]
        public string CnpjDoEmitente { get; set; }
        [DisplayName("Nome do Emitente")]
        public string NomeDoEmitente { get; set; }
        [DisplayName("Transportadora")]
        public string NomeDaTransportadora { get; set; }

        public bool PermiteEditar { get; set; }
    }

    public class NotaFiscalDeColetaVm
    {
        public int? Id { get; set; }
        [DisplayName("Número")]
        [Required(ErrorMessage = "Número é obrigatório")]
        public string Numero { get; set; }
        
        [DisplayName("Série")]
        [Required(ErrorMessage = "Série é obrigatório")]
        public string Serie { get; set; }

        [DisplayName("Nº do Conhecimento")]
        [Required(ErrorMessage = "Nº do Conhecimento é obrigatório")]
        public string NumeroDoConhecimento { get; set; }
        [DisplayName("Data de Emissão")]
        [Required(ErrorMessage = "Data de Emissão é obrigatório")]
        public string DataDeEmissao { get; set; }
        [Required(ErrorMessage = "Peso é obrigatório")]
        public decimal Peso { get; set; }

        [Required(ErrorMessage = "Valor é obrigatório")]
        public decimal Valor{ get; set; }

        //[DisplayName("Número do Contrato")]
        //public string NumeroDoContrato { get; set; }

        //[DisplayName("CNPJ do Emitente")]
        //public string CnpjDoEmitente { get; set; }
        //[DisplayName("Nome do Emitente")]
        //public string NomeDoEmitente { get; set; }

    }
}
