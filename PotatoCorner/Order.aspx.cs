using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace PotCor
{
    public partial class Order : System.Web.UI.Page
    {
        const decimal DELIVERY_FEE = 50m;
        const decimal ROYALTY_DISCOUNT_RATE = 0.10m;

        public class CartItem
        {
            public string Product { get; set; }
            public string Size { get; set; }
            public string Flavor { get; set; }
            public int Qty { get; set; }
            public decimal UnitPrice { get; set; }
            public decimal LineTotal => UnitPrice * Qty;
        }

        private List<CartItem> Cart
        {
            get
            {
                if (Session["Cart"] == null)
                    Session["Cart"] = new List<CartItem>();
                return (List<CartItem>)Session["Cart"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Cart"] = new List<CartItem>();
                hdnFriesQty.Value = "1";
                hdnChickenQty.Value = "1";
                hdnLoopysQty.Value = "1";
            }
            BindCart();
        }

        protected void lnkProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Profile.aspx");
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            string royaltyNo = txtRoyaltyNo.Text.Trim();
            if (string.IsNullOrEmpty(royaltyNo))
            {
                lblRoyaltyMsg.Text = "Please enter a royalty number.";
                lblRoyaltyMsg.CssClass = "status-msg status-error";
                lblRoyaltyMsg.Visible = true;
                return;
            }

            lblRoyaltyMsg.Text = "✓ Royalty number validated! 10% discount applied.";
            lblRoyaltyMsg.CssClass = "status-msg status-success";
            lblRoyaltyMsg.Visible = true;
            hdnIsRoyalty.Value = "true";
            UpdateCartTotals();
        }

        // Chicken quantity controls
        protected void btnChickenMinus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnChickenQty.Value);
            if (qty > 1) qty--;
            hdnChickenQty.Value = qty.ToString();
            lblChickenQty.Text = qty.ToString();
        }

        protected void btnChickenPlus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnChickenQty.Value);
            qty++;
            hdnChickenQty.Value = qty.ToString();
            lblChickenQty.Text = qty.ToString();
        }

        // Loopys quantity controls
        protected void btnLoopysMinus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnLoopysQty.Value);
            if (qty > 1) qty--;
            hdnLoopysQty.Value = qty.ToString();
            lblLoopysQty.Text = qty.ToString();
        }

        protected void btnLoopysPlus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnLoopysQty.Value);
            qty++;
            hdnLoopysQty.Value = qty.ToString();
            lblLoopysQty.Text = qty.ToString();
        }

        // French Fries quantity controls
        protected void btnFriesMinus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnFriesQty.Value);
            if (qty > 1) qty--;
            hdnFriesQty.Value = qty.ToString();
            lblFriesQty.Text = qty.ToString();
        }

        protected void btnFriesPlus_Click(object sender, EventArgs e)
        {
            int qty = int.Parse(hdnFriesQty.Value);
            qty++;
            hdnFriesQty.Value = qty.ToString();
            lblFriesQty.Text = qty.ToString();
        }

        protected void btnAddFries_Click(object sender, EventArgs e)
        {
            string size = "";
            decimal price = 0;

            if (rbFriesRegular.Checked) { size = "Regular"; price = 39; }
            else if (rbFriesLarge.Checked) { size = "Large"; price = 58; }
            else if (rbFriesJumbo.Checked) { size = "Jumbo"; price = 97; }
            else if (rbFriesMega.Checked) { size = "Mega"; price = 135; }
            else if (rbFriesGiga.Checked) { size = "Giga"; price = 198; }
            else if (rbFriesTerra.Checked) { size = "Terra"; price = 228; }
            else
            {
                lblErrorMsg.Text = "Please select a size for French Fries.";
                lblErrorMsg.Visible = true;
                return;
            }

            string flavor = "";
            if (rbFriesSourCream.Checked) flavor = "Sour Cream";
            else if (rbFriesBBQ.Checked) flavor = "BBQ";
            else if (rbFriesCheese.Checked) flavor = "Cheese";
            else if (rbFriesSalt.Checked) flavor = "Salt";
            else
            {
                lblErrorMsg.Text = "Please select a flavor for French Fries.";
                lblErrorMsg.Visible = true;
                return;
            }

            int qty = int.Parse(hdnFriesQty.Value);
            Cart.Add(new CartItem
            {
                Product = "French Fries",
                Size = size,
                Flavor = flavor,
                Qty = qty,
                UnitPrice = price
            });

            // Reset
            rbFriesRegular.Checked = false;
            rbFriesLarge.Checked = false;
            rbFriesJumbo.Checked = false;
            rbFriesMega.Checked = false;
            rbFriesGiga.Checked = false;
            rbFriesTerra.Checked = false;
            rbFriesSourCream.Checked = false;
            rbFriesBBQ.Checked = false;
            rbFriesCheese.Checked = false;
            rbFriesSalt.Checked = false;
            hdnFriesQty.Value = "1";
            lblFriesQty.Text = "1";
            lblErrorMsg.Visible = false;

            BindCart();
        }

        protected void btnAddChicken_Click(object sender, EventArgs e)
        {
            string size = "";
            decimal price = 0;

            if (rbChickenSolo.Checked) { size = "Solo"; price = 75; }
            else if (rbChickenLarge.Checked) { size = "Large Mix"; price = 95; }
            else if (rbChickenMega.Checked) { size = "Mega Mix"; price = 199; }
            else
            {
                lblErrorMsg.Text = "Please select a size for Chicken Pops.";
                lblErrorMsg.Visible = true;
                return;
            }

            string flavor = "";
            if (rbChickenSourCream.Checked) flavor = "Sour Cream";
            else if (rbChickenBBQ.Checked) flavor = "BBQ";
            else if (rbChickenCheese.Checked) flavor = "Cheese";
            else if (rbChickenSalt.Checked) flavor = "Salt";
            else
            {
                lblErrorMsg.Text = "Please select a flavor for Chicken Pops.";
                lblErrorMsg.Visible = true;
                return;
            }

            int qty = int.Parse(hdnChickenQty.Value);
            Cart.Add(new CartItem
            {
                Product = "Chicken Pops",
                Size = size,
                Flavor = flavor,
                Qty = qty,
                UnitPrice = price
            });

            // Reset
            rbChickenSolo.Checked = false;
            rbChickenLarge.Checked = false;
            rbChickenMega.Checked = false;
            rbChickenSourCream.Checked = false;
            rbChickenBBQ.Checked = false;
            rbChickenCheese.Checked = false;
            rbChickenSalt.Checked = false;
            hdnChickenQty.Value = "1";
            lblChickenQty.Text = "1";
            lblErrorMsg.Visible = false;

            BindCart();
        }

        protected void btnAddLoopys_Click(object sender, EventArgs e)
        {
            string size = "";
            decimal price = 0;

            if (rbLoopysLarge.Checked) { size = "Large"; price = 75; }
            else if (rbLoopysMega.Checked) { size = "Mega"; price = 135; }
            else
            {
                lblErrorMsg.Text = "Please select a size for Loopys.";
                lblErrorMsg.Visible = true;
                return;
            }

            string flavor = "";
            if (rbLoopysSourCream.Checked) flavor = "Sour Cream";
            else if (rbLoopysBBQ.Checked) flavor = "BBQ";
            else if (rbLoopysCheese.Checked) flavor = "Cheese";
            else if (rbLoopysSalt.Checked) flavor = "Salt";
            else
            {
                lblErrorMsg.Text = "Please select a flavor for Loopys.";
                lblErrorMsg.Visible = true;
                return;
            }

            int qty = int.Parse(hdnLoopysQty.Value);
            Cart.Add(new CartItem
            {
                Product = "Loopys",
                Size = size,
                Flavor = flavor,
                Qty = qty,
                UnitPrice = price
            });

            // Reset
            rbLoopysLarge.Checked = false;
            rbLoopysMega.Checked = false;
            rbLoopysSourCream.Checked = false;
            rbLoopysBBQ.Checked = false;
            rbLoopysCheese.Checked = false;
            rbLoopysSalt.Checked = false;
            hdnLoopysQty.Value = "1";
            lblLoopysQty.Text = "1";
            lblErrorMsg.Visible = false;

            BindCart();
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int index = int.Parse(e.CommandArgument.ToString());
                Cart.RemoveAt(index);
                BindCart();
            }
        }

        protected void btnDeliveryType_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            btnWalkIn.CssClass = "option-btn";
            btnDelivery.CssClass = "option-btn";
            btn.CssClass = "option-btn selected";
            
            hdnDeliveryType.Value = btn.ID == "btnWalkIn" ? "WalkIn" : "Delivery";
            UpdateCartTotals();
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            btnGoTyme.CssClass = "option-btn";
            btnMayaBank.CssClass = "option-btn";
            btnGCash.CssClass = "option-btn";
            btnPoints.CssClass = "option-btn";
            btn.CssClass = "option-btn selected";
            
            hdnPaymentMethod.Value = btn.Text;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text.Trim()) ||
                string.IsNullOrEmpty(txtAddress.Text.Trim()) ||
                string.IsNullOrEmpty(txtContact.Text.Trim()))
            {
                lblErrorMsg.Text = "Please fill in all customer information.";
                lblErrorMsg.Visible = true;
                return;
            }

            if (Cart.Count == 0)
            {
                lblErrorMsg.Text = "Your cart is empty. Please add at least one item.";
                lblErrorMsg.Visible = true;
                return;
            }

            if (string.IsNullOrEmpty(hdnPaymentMethod.Value))
            {
                lblErrorMsg.Text = "Please select a payment method.";
                lblErrorMsg.Visible = true;
                return;
            }

            // Validate payment amount (skip for Points)
            if (hdnPaymentMethod.Value != "Points")
            {
                decimal amountPaid;
                if (!decimal.TryParse(txtAmountPaid.Text.Trim(), out amountPaid) || amountPaid <= 0)
                {
                    lblErrorMsg.Text = "Please enter a valid payment amount.";
                    lblErrorMsg.Visible = true;
                    return;
                }

                decimal total = decimal.Parse(lblTotal.Text);
                if (amountPaid < total)
                {
                    lblErrorMsg.Text = $"Insufficient amount. Total is PHP {total:0.00}. You entered PHP {amountPaid:0.00}.";
                    lblErrorMsg.Visible = true;
                    return;
                }

                Session["AmountPaid"] = amountPaid.ToString("0.00");
                Session["Change"] = (amountPaid - total).ToString("0.00");
            }

            decimal orderTotal = decimal.Parse(lblTotal.Text);
            int pointsEarned = (int)(orderTotal / 500) * 2;

            Session["OrderName"] = txtName.Text.Trim();
            Session["OrderAddress"] = txtAddress.Text.Trim();
            Session["OrderContact"] = txtContact.Text.Trim();
            Session["OrderDelivery"] = hdnDeliveryType.Value == "Delivery" ? "Delivery" : "Walk-in";
            Session["OrderIsRoyalty"] = hdnIsRoyalty.Value;
            Session["OrderTotal"] = lblTotal.Text;
            Session["PaymentMethod"] = hdnPaymentMethod.Value;
            Session["PointsEarned"] = pointsEarned.ToString();
            if (!string.IsNullOrEmpty(txtRoyaltyNo.Text.Trim()))
                Session["RoyaltyNo"] = txtRoyaltyNo.Text.Trim();

            Response.Redirect("~/Receipt.aspx");
        }

        private void BindCart()
        {
            var cart = Cart;
            if (cart.Count == 0)
            {
                pnlEmptyCart.Visible = true;
                pnlCart.Visible = false;
            }
            else
            {
                pnlEmptyCart.Visible = false;
                pnlCart.Visible = true;
                rptCart.DataSource = cart;
                rptCart.DataBind();
                UpdateCartTotals();
            }
        }

        private void UpdateCartTotals()
        {
            decimal subtotal = 0;
            foreach (var item in Cart)
                subtotal += item.LineTotal;

            bool isRoyalty = hdnIsRoyalty.Value == "true";
            bool isDelivery = hdnDeliveryType.Value == "Delivery";

            decimal discount = isRoyalty ? subtotal * ROYALTY_DISCOUNT_RATE : 0;
            decimal delivery = isDelivery ? DELIVERY_FEE : 0;
            decimal total = subtotal - discount + delivery;

            lblSubtotal.Text = subtotal.ToString("0.00");
            lblDiscount.Text = discount.ToString("0.00");
            lblDeliveryFee.Text = delivery.ToString("0.00");
            lblTotal.Text = total.ToString("0.00");
        }
    }
}
