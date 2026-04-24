using System;

namespace PotCor
{
    public partial class Membership : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegisterForm.aspx");
        }
    }
}
