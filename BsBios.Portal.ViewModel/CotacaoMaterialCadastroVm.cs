﻿using System.ComponentModel;

namespace BsBios.Portal.ViewModel
{
    public class CotacaoMaterialCadastroVm: CotacaoMaterialInformarVm
    {
        [DisplayName("Descrição: ")]
        public string DescricaoDoProcessoDeCotacao { get; set; }
        [DisplayName("Requisitos: ")]
        public string Requisitos { get; set; }
        [DisplayName("Data Limite de Retorno: ")]
        public string DataLimiteDeRetorno { get; set; }
        [DisplayName("Status: ")]
        public string Status { get; set; }

        /// <summary>
        /// usuada para indicar se os campos da tela serão habilitados para edição
        /// </summary>
        public bool PermiteEditar { get; set; }
        public int IdFornecedorParticipante { get; set; }
    }
}
