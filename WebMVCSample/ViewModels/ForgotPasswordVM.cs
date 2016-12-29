using System.ComponentModel.DataAnnotations;

namespace WebInventory.ViewModels
{
    public class ForgotPasswordVM
    {
        [Display(Name = "Registered Email")]
        [Required(ErrorMessage = "Registered Email could not be blank..")]
        [DataType(DataType.EmailAddress, ErrorMessage = "Enter valid email id..")]
        [RegularExpression(@"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}", ErrorMessage = "Please enter valid email id..")]
        public string RegisteredEmail { get; set; }
    }
}