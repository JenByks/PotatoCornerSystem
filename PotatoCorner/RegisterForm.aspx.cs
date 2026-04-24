using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PotCor
{
    public partial class RegisterForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnPaymentMethod_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            btnGoTyme.CssClass = "payment-btn";
            btnMayaBank.CssClass = "payment-btn";
            btnGCash.CssClass = "payment-btn";
            btnPoints.CssClass = "payment-btn";
            btn.CssClass = "payment-btn selected";
            
            hdnPaymentMethod.Value = btn.Text;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Validate all fields
            if (string.IsNullOrWhiteSpace(txtFirstName.Text) ||
                string.IsNullOrWhiteSpace(txtLastName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text) ||
                string.IsNullOrWhiteSpace(txtContact.Text) ||
                string.IsNullOrWhiteSpace(txtAddress.Text) ||
                string.IsNullOrWhiteSpace(txtBirthDate.Text))
            {
                ShowMessage("Please fill in all required fields.", false);
                return;
            }

            // Validate file upload
            if (!fileUploadPicture.HasFile)
            {
                ShowMessage("Please upload your profile picture.", false);
                return;
            }

            // Validate file type
            string fileExtension = Path.GetExtension(fileUploadPicture.FileName).ToLower();
            if (fileExtension != ".png" && fileExtension != ".jpg" && fileExtension != ".jpeg")
            {
                ShowMessage("Only PNG and JPG images are allowed.", false);
                return;
            }

            // Validate file size (max 5MB)
            if (fileUploadPicture.PostedFile.ContentLength > 5242880)
            {
                ShowMessage("Image size must be less than 5MB.", false);
                return;
            }

            // Validate payment method
            if (string.IsNullOrEmpty(hdnPaymentMethod.Value))
            {
                ShowMessage("Please select a payment method.", false);
                return;
            }

            // Validate amount paid
            decimal amountPaid;
            if (!decimal.TryParse(txtAmountPaid.Text.Trim(), out amountPaid) || amountPaid < 100)
            {
                ShowMessage("Please enter at least PHP 100 for registration fee.", false);
                return;
            }

            try
            {
                // Generate unique royalty number
                string royaltyNumber = "RC" + DateTime.Now.ToString("yyyyMMddHHmmss");

                // Save uploaded image
                string uploadsFolder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                string fileName = royaltyNumber + fileExtension;
                string filePath = Path.Combine(uploadsFolder, fileName);
                fileUploadPicture.SaveAs(filePath);

                // Calculate change
                decimal change = amountPaid - 100;

                // Store registration data in session
                Session["RoyaltyNumber"] = royaltyNumber;
                Session["MemberFirstName"] = txtFirstName.Text.Trim();
                Session["MemberLastName"] = txtLastName.Text.Trim();
                Session["MemberEmail"] = txtEmail.Text.Trim();
                Session["MemberContact"] = txtContact.Text.Trim();
                Session["MemberAddress"] = txtAddress.Text.Trim();
                Session["MemberBirthDate"] = txtBirthDate.Text;
                Session["MemberPicture"] = "~/Uploads/" + fileName;
                Session["RegistrationDate"] = DateTime.Now.ToString("MMMM dd, yyyy");
                Session["RegistrationFee"] = "100.00";
                Session["PaymentMethod"] = hdnPaymentMethod.Value;
                Session["AmountPaid"] = amountPaid.ToString("0.00");
                Session["ChangeAmount"] = change.ToString("0.00");

                // TODO: Save to database here
                // Insert into RoyaltyMembership and Customers tables

                // Redirect to receipt
                Response.Redirect("~/MembershipReceipt.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Registration failed: " + ex.Message, false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "success-msg" : "error-msg";
            lblMessage.Visible = true;
        }
    }
}
