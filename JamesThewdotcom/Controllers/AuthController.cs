using Microsoft.AspNetCore.Mvc;

namespace JamesThewdotcom.Controllers
{
    public class AuthController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
