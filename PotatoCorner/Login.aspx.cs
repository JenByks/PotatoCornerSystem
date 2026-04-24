using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PotCor
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter your email and password.";
                lblError.Visible = true;
                return;
            }

            // TODO: add database validation here later
            lblError.Text = "Invalid email or password. Please try again.";
            lblError.Visible = true;
        }

        protected void lnkRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegisterForm.aspx");
        }
    }
}
