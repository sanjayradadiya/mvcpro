using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace WebInventory.ViewModels
{
    public class ResetPasswordVM
    {
        [Display(Name = "Registered Email")]
        [Required(ErrorMessage = "Registered Email could not be blank..")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Enter valid email id..")]
        [RegularExpression(@"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}", ErrorMessage = "Please enter valid email id..")]
        public string RegisteredEmail { get; set; }

        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Old password could not be blank..")]
        [MinLength(5, ErrorMessage = "Minimum length 5 characters required..")]
        [Display(Name = "Old Password")]
        public string OldPassword { get; set; }

        [DataType(DataType.Password)]
        [Required(ErrorMessage = "New password could not be blank..")]
        [MinLength(5, ErrorMessage = "Minimum length 5 characters required..")]
        [Display(Name = "New Password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Conirm password could not be blank..")]
        [MinLength(5, ErrorMessage = "Minimum length 5 characters required..")]
        [Display(Name = "Confirm Password")]
        public string ConfirmPassword { get; set; }
    }
}