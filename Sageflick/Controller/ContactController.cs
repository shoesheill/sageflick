using Microsoft.AspNetCore.Mvc;

namespace Sageflick.Controller
{
    // ContactController.cs
    public class ContactController : Controller
    {
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Submit(Contact contact)
        {
            // Process the submitted data (e.g., save to a database, send an email, etc.)
            // For this example, we'll just show the submitted data on the confirmation page.
            return View(contact);
        }
    }

}
