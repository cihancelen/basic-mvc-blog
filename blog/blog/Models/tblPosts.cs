namespace blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Web.Mvc;

    public partial class tblPosts
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblPosts()
        {
            tblLike = new HashSet<tblLike>();
            tblYorumlar = new HashSet<tblYorumlar>();
            tblEtiket = new HashSet<tblEtiket>();
        }

        [Key]
        public int PostId { get; set; }

        [StringLength(300)]
        public string Baslik { get; set; }

        [StringLength(500)]
        public string Aciklama { get; set; }

        [AllowHtml]
        public string Icerik { get; set; }

        public int Views { get; set; }

        public DateTime? EklenmeTarihi { get; set; }

        public int? YazarId { get; set; }

        public int? KategoriId { get; set; }

        [StringLength(500)]
        public string PostResimUrl { get; set; }

        public virtual tblKategoriler tblKategoriler { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblLike> tblLike { get; set; }

        public virtual tblYazarlar tblYazarlar { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblYorumlar> tblYorumlar { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblEtiket> tblEtiket { get; set; }
    }
}
