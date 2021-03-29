namespace blog.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblRutbe")]
    public partial class tblRutbe
    {
        [Key]
        public int RutbeId { get; set; }

        [StringLength(50)]
        public string Rutbe { get; set; }

        public string RutbeResim { get; set; }
    }
}
