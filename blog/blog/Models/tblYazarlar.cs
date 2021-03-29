namespace blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblYazarlar")]
    public partial class tblYazarlar
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblYazarlar()
        {
            tblLike = new HashSet<tblLike>();
            tblPosts = new HashSet<tblPosts>();
            tblYorumlar = new HashSet<tblYorumlar>();
        }

        [Key]
        public int YazarId { get; set; }

        [StringLength(100)]
        public string Ad { get; set; }

        [StringLength(100)]
        public string Soyad { get; set; }

        [Column(TypeName = "date")]
        public DateTime DogumTarihi { get; set; }

        [StringLength(50)]
        public string KullaniciAdi { get; set; }

        [StringLength(100)]
        public string Email { get; set; }

        [StringLength(50)]
        public string Parola { get; set; }

        [StringLength(10)]
        public string Cinsiyet { get; set; }

        public int? RutbeId { get; set; }

        public DateTime? KayitTarihi { get; set; }

        public string AvatarResim { get; set; }

        public bool? YazarOnay { get; set; }

        [StringLength(200)]
        public string AktivasyonKodu { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblLike> tblLike { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblPosts> tblPosts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblYorumlar> tblYorumlar { get; set; }
    }
}
