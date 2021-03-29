namespace blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Web.Mvc;

    [Table("tblYorumlar")]
    public partial class tblYorumlar
    {
        [Key]
        public int YorumId { get; set; }
                
        [StringLength(500)]
        [AllowHtml]
        public string Yorum { get; set; }

        public DateTime? YorumETarihi { get; set; }

        public int? PostId { get; set; }

        public int? YazarId { get; set; }

        public virtual tblPosts tblPosts { get; set; }

        public virtual tblYazarlar tblYazarlar { get; set; }
    }
}
