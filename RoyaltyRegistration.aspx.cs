using System;
using System.IO;

namespace PotatoCorner
{
    public partial class RoyaltyRegistration : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string address = txtAddress.Text;
            string phone = txtPhone.Text;
            string email = txtEmail.Text;

            string filePath = "";

            if (fileUpload.HasFile)
            {
                string fileName = Path.GetFileName(fileUpload.FileName);
                filePath = "~/Images/" + fileName;
                fileUpload.SaveAs(Server.MapPath(filePath));
            }

            // Redirect to receipt page
            Response.Redirect($"receipt.aspx?name={name}&address={address}&phone={phone}&email={email}&image={filePath}");
        }
    }
}