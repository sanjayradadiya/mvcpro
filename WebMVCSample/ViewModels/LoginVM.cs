using System.ComponentModel.DataAnnotations;

namespace WebInventory.ViewModels
{
    public class LoginVM
    {
        [Required(ErrorMessage="User Name is required..")]
        [Display(Name="User Name")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Password could not be blank..")]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Remember me")]
        public bool RememberMe { get; set; }
    }
}