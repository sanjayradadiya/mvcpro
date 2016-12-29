using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebInventory.Areas.Admin.ViewModels
{
    public class ProcMasVM
    {
        [Required(ErrorMessage="Process Group Could Not be Blank")]
        [Display(Name = "Process Group")]
        public string mProcGrp { get; set; }

        [Display(Name = "ProcCd")]
        public int PrcId { get; set; }

        [Required(ErrorMessage = "Process Name Could Not be Blank")]
        [Display(Name = "Process Name")]
        public string mPrcNm { get; set; }

        [Required(ErrorMessage = "Process Short Name Could Not be Blank")]
        [Display(Name = "Short Name")]
        public string mPrcShortNm { get; set; }

        [Display(Name = "Order")]
        [Required(ErrorMessage = "Process Order Could Not be Blank")]
        public int mPrcOrd { get; set; }

        [Required(ErrorMessage = "Process Status Could Not be Blank")]
        [Display(Name = "Status")]
        public string mPrcStatus { get; set; }
    }
}