﻿using System;
using System.Collections.Generic;
using System.Linq;
using BsBios.Portal.Domain.Model;
using BsBios.Portal.Infra.Repositories.Contracts;

namespace BsBios.Portal.Infra.Repositories.Implementations
{
    public class Usuarios: CompleteRepositoryNh<Usuario>, IUsuarios
    {
        public Usuarios(IUnitOfWorkNh unitOfWorkNh) : base(unitOfWorkNh)
        {
        }

        public IUsuarios BuscaPorId(int idUsuario)
        {
            Query = Query.Where(u => u.Id == idUsuario);
            return this;
        }
    }
}
