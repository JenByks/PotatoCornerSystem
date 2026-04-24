using System;

namespace PotCor
{
    public partial class MembershipReceipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if session data exists
                if (Session["RoyaltyNumber"] == null)
                {
                    Response.Redirect("~/RegisterForm.aspx");
                    return;
                }

                // Load data from session
                lblRoyaltyNumber.Text = Session["RoyaltyNumber"].ToString();
                lblMemberID.Text = Session["RoyaltyNumber"].ToString();
                lblFullName.Text = Session["MemberFirstName"] + " " + Session["MemberLastName"];
                lblEmail.Text = Session["MemberEmail"].ToString();
                lblContact.Text = Session["MemberContact"].ToString();
                lblAddress.Text = Session["MemberAddress"].ToString();
                lblDateJoined.Text = Session["RegistrationDate"].ToString();
                lblFee.Text = Session["RegistrationFee"].ToString();
                lblPaymentMethod.Text = Session["PaymentMethod"].ToString();
                lblAmountPaid.Text = Session["AmountPaid"].ToString();
                lblChange.Text = Session["ChangeAmount"].ToString();
                
                // Load member photo
                if (Session["MemberPicture"] != null)
                {
                    imgMemberPhoto.ImageUrl = Session["MemberPicture"].ToString();
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }
    }
}
