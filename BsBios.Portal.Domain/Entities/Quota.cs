using System;
using BsBios.Portal.Common;
using BsBios.Portal.Common.Exceptions;

namespace BsBios.Portal.Domain.Entities
{
    public class Quota: IAggregateRoot
    {
        public virtual Fornecedor Fornecedor { get; protected set; }
        public virtual Enumeradores.MaterialDeCarga Material { get; protected set; }
        public virtual Enumeradores.FluxoDeCarga FluxoDeCarga { get; protected set; }
        public virtual string Terminal { get; protected set; }
        public virtual DateTime Data { get; protected set; }
        public virtual decimal PesoTotal { get; protected set; }
        public virtual decimal PesoAgendado { get; protected set; }

        public virtual decimal PesoDisponivel
        {
            get { return PesoTotal - PesoAgendado ; }
        }

        protected Quota(){}

        public Quota(Enumeradores.MaterialDeCarga materialDeCarga, Fornecedor fornecedor, string terminal, DateTime data, decimal pesoTotal)
        {
            Fornecedor = fornecedor;
            Terminal = terminal;
            Data = data;
            PesoTotal = pesoTotal;
            Material = materialDeCarga;
            if (materialDeCarga == Enumeradores.MaterialDeCarga.Soja)
            {
                FluxoDeCarga = Enumeradores.FluxoDeCarga.Descarregamento;
            }
            if (materialDeCarga == Enumeradores.MaterialDeCarga.Farelo)
            {
                FluxoDeCarga = Enumeradores.FluxoDeCarga.Carregamento;
            }
        }

        public virtual void AlterarPeso(decimal peso)
        {
            PesoTotal = peso;
        }

        public virtual void AdicionarAgendamento(AgendamentoDeCarga agendamento)
        {
            PesoAgendado += agendamento.PesoTotal;
            if (PesoAgendado > PesoTotal)
            {
                throw new PesoAgendadoSuperiorAoPesoDaQuotaException(PesoAgendado, PesoTotal);
            }
        }


        #region Equality Members

        protected bool Equals(Quota other)
        {
            return FluxoDeCarga == other.FluxoDeCarga && Equals(Fornecedor, other.Fornecedor) && string.Equals(Terminal, other.Terminal) && Data.Equals(other.Data);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;
            return Equals((Quota) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = (int) FluxoDeCarga;
                hashCode = (hashCode*397) ^ (Fornecedor != null ? Fornecedor.GetHashCode() : 0);
                hashCode = (hashCode*397) ^ (Terminal != null ? Terminal.GetHashCode() : 0);
                hashCode = (hashCode*397) ^ Data.GetHashCode();
                return hashCode;
            }
        }

        #endregion

    }
}