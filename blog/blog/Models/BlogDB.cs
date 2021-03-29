namespace blog.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class BlogDB : DbContext
    {
        public BlogDB()
            : base("name=BlogDB")
        {
        }

        public virtual DbSet<tblEtiket> tblEtiket { get; set; }
        public virtual DbSet<tblKategoriler> tblKategoriler { get; set; }
        public virtual DbSet<tblLike> tblLike { get; set; }
        public virtual DbSet<tblPosts> tblPosts { get; set; }
        public virtual DbSet<tblRutbe> tblRutbe { get; set; }
        public virtual DbSet<tblYazarlar> tblYazarlar { get; set; }
        public virtual DbSet<tblYorumlar> tblYorumlar { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<tblEtiket>()
                .Property(e => e.Etiket)
                .IsUnicode(false);

            modelBuilder.Entity<tblEtiket>()
                .HasMany(e => e.tblPosts)
                .WithMany(e => e.tblEtiket)
                .Map(m => m.ToTable("tblPostEtiket").MapLeftKey("EtiketId").MapRightKey("PostId"));

            modelBuilder.Entity<tblYazarlar>()
                .Property(e => e.KullaniciAdi)
                .IsUnicode(false);

            modelBuilder.Entity<tblYazarlar>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<tblYazarlar>()
                .Property(e => e.Cinsiyet)
                .IsFixedLength();
        }
    }
}
