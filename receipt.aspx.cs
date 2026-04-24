using System;

namespace PotatoCorner
{
    public partial class receipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblName.Text = Request.QueryString["name"];
            lblAddress.Text = Request.QueryString["address"];
            lblPhone.Text = Request.QueryString["phone"];
            lblEmail.Text = Request.QueryString["email"];

            imgUser.ImageUrl = Request.QueryString["image"];
        }
    }
}