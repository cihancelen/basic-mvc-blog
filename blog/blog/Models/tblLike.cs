namespace blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblLike")]
    public partial class tblLike
    {
        [Key]
        public int LikeId { get; set; }

        public int LikeDurum { get; set; }

        public int? YazarId { get; set; }

        public int? PostId { get; set; }

        public virtual tblPosts tblPosts { get; set; }

        public virtual tblYazarlar tblYazarlar { get; set; }
    }
}
