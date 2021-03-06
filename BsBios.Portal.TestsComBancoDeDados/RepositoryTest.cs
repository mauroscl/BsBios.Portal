﻿using BsBios.Portal.Infra.Repositories.Contracts;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using NHibernate;
using StructureMap;

namespace BsBios.Portal.TestsComBancoDeDados
{
    [TestClass]
    public class RepositoryTest
    {
        protected static IUnitOfWorkNh UnitOfWorkNh;
        protected static ISession Session; 

        //[ClassInitialize]
        public static void Initialize(TestContext testContext)
        {
            Session = ObjectFactory.GetInstance<ISession>();
            UnitOfWorkNh = ObjectFactory.GetInstance<IUnitOfWorkNh>();
        }

        //[ClassCleanup]
        public static void Cleanup()
        {
            UnitOfWorkNh.Dispose();
        }

        public static void RollbackSessionTransaction()
        {
            if (Session.Transaction != null && Session.Transaction.IsActive)
            {
                Session.Transaction.Rollback();
            }
        }
    }
}
