using Microsoft.AspNetCore.Mvc;

namespace JamesThewdotcom.Controllers
{
    public class Admin : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
