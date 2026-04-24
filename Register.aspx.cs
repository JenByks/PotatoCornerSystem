using System;
using System.Web.UI;
using System.Xml.Linq;

namespace PotatoCorner
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(name) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(username) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.Text = "Please fill in all fields.";
                lblMessage.CssClass = "error-msg";
                lblMessage.Visible = true;
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                lblMessage.CssClass = "error-msg";
                lblMessage.Visible = true;
                return;
            }

            // TODO: insert into database later

            lblMessage.Text = "Registration successful! You can now login.";
            lblMessage.CssClass = "success-msg";
            lblMessage.Visible = true;
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}