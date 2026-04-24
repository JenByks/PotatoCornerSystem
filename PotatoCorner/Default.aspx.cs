using System;
using System.Web.UI;

namespace PotCor
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void lnkProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Profile.aspx");
        }

        protected void btnOrderNav_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Order.aspx");
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Order.aspx");
        }

        protected void lnkMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Menu.aspx");
        }

        protected void lnkMembership_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Membership.aspx");
        }
    }
}
