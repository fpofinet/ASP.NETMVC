﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Ce code a été généré à partir d'un modèle.
//
//     Des modifications manuelles apportées à ce fichier peuvent conduire à un comportement inattendu de votre application.
//     Les modifications manuelles apportées à ce fichier sont remplacées si le code est régénéré.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ASP.NETMVC.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class BiblioEntities : DbContext
    {
        public BiblioEntities()
            : base("name=BiblioEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AUTEURS> AUTEURS { get; set; }
        public virtual DbSet<COURANTS> COURANTS { get; set; }
        public virtual DbSet<GENRES> GENRES { get; set; }
        public virtual DbSet<LIVRES> LIVRES { get; set; }
    }
}
