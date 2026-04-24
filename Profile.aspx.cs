using System;
using System.Web.UI;
using System.Web.UI.WebControls;

// ── UNCOMMENT THESE WHEN DATABASE IS READY ────────────────────────────────────
// using System.Data;
// using System.Data.SqlClient;
// using System.Configuration;

namespace PotCor
{
    public partial class Profile : Page
    {
        // ── DATABASE CONNECTION (uncomment when DB is ready) ──────────────────
        // private readonly string _connStr =
        //     ConfigurationManager.ConnectionStrings["PotCorDB"].ConnectionString;

        // ─────────────────────────────────────────────────────────────────────
        // PAGE LOAD
        // ─────────────────────────────────────────────────────────────────────
        protected void Page_Load(object sender, EventArgs e)
        {
            // ── STEP 1: UI MODE — loads sample data so the page runs now ─────
            if (!IsPostBack)
            {
                LoadSampleData();
            }

            // ── STEP 2: SESSION CHECK (uncomment when login is ready) ─────────
            // if (Session["UserID"] == null)
            // {
            //     Response.Redirect("Login.aspx");
            //     return;
            // }
            // if (!IsPostBack)
            // {
            //     int userId = Convert.ToInt32(Session["UserID"]);
            //     LoadProfile(userId);
            //     LoadRecentOrders(userId);
            // }
        }

        // ─────────────────────────────────────────────────────────────────────
        // SAMPLE DATA — hardcoded so the UI works without a database
        // Replace this with LoadProfile() + LoadRecentOrders() when DB is ready
        // ─────────────────────────────────────────────────────────────────────
        private void LoadSampleData()
        {
            // ── Avatar ────────────────────────────────────────────────────────
            lblInitials.Text = "JD";
            lblFullName.Text = "Juan Dela Cruz";
            lblEmail.Text = "juan.delacruz@email.com";
            lblTier.Text = "Bronze";

            badgeMember.InnerText = "Bronze Member";
            badgeMember.Attributes["class"] = "badge badge-bronze";

            // ── Personal Info ─────────────────────────────────────────────────
            lblInfoName.Text = "Juan Dela Cruz";
            lblInfoPhone.Text = "09XX XXX XXXX";
            lblInfoAddress.Text = "Quezon City, Metro Manila";
            lblMemberSince.Text = "January 2025";

            // ── Royalty Card ──────────────────────────────────────────────────
            int totalPoints = 240;
            int prevTierPts = 0;    // Bronze starts at 0
            int nextTierPts = 500;  // Silver starts at 500
            int progress = (int)Math.Round((double)(totalPoints - prevTierPts)
                               / (nextTierPts - prevTierPts) * 100);  // = 48%

            lblPoints.Text = string.Format("{0} pts", totalPoints);
            lblNextTier.Text = string.Format("Next tier: Silver ({0} pts)", nextTierPts);
            barFill.Style["width"] = string.Format("{0}%", progress);
            lblBarMin.Text = prevTierPts.ToString();
            lblBarMax.Text = nextTierPts.ToString();
            lblCardNo.Text = "RC-00421";
            lblOrderCount.Text = "12 orders";
            lblRoyaltyBadge.Text = "Bronze";
            lblRoyaltyBadge.CssClass = "badge badge-bronze";

            // ── Recent Orders ─────────────────────────────────────────────────
            // Using a simple DataTable so the Repeater works without a database
            System.Data.DataTable dt = new System.Data.DataTable();
            dt.Columns.Add("OrderCode");
            dt.Columns.Add("OrderDate");
            dt.Columns.Add("OrderSummary");
            dt.Columns.Add("Status");

            dt.Rows.Add("#ORD-1021", "April 20, 2026", "Large Fries x2", "Delivered");
            dt.Rows.Add("#ORD-1018", "April 18, 2026", "Loaded Fries x1", "On the way");
            dt.Rows.Add("#ORD-1014", "April 15, 2026", "Regular Fries x3", "Delivered");

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }

        // ─────────────────────────────────────────────────────────────────────
        // DATABASE METHODS — uncomment and use these when DB is ready
        // ─────────────────────────────────────────────────────────────────────

        // private void LoadProfile(int userId)
        // {
        //     using (SqlConnection con = new SqlConnection(_connStr))
        //     using (SqlCommand cmd = new SqlCommand("sp_GetUserProfile", con))
        //     {
        //         cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //         cmd.Parameters.AddWithValue("@UserID", userId);
        //         con.Open();
        //         using (SqlDataReader dr = cmd.ExecuteReader())
        //         {
        //             if (dr.Read())
        //             {
        //                 string fullName   = dr["FullName"].ToString();
        //                 string email      = dr["Email"].ToString();
        //                 string phone      = dr["Phone"].ToString();
        //                 string address    = dr["Address"].ToString();
        //                 DateTime joined   = Convert.ToDateTime(dr["CreatedAt"]);
        //                 int totalPoints   = Convert.ToInt32(dr["TotalPoints"]);
        //                 int orderCount    = Convert.ToInt32(dr["OrderCount"]);
        //                 string cardNo     = dr["RoyaltyCardNo"].ToString();
        //
        //                 string[] nameParts = fullName.Trim().Split(' ');
        //                 string initials = nameParts.Length >= 2
        //                     ? string.Format("{0}{1}", nameParts[0][0], nameParts[nameParts.Length - 1][0])
        //                     : fullName.Substring(0, Math.Min(2, fullName.Length));
        //
        //                 string tier     = GetTier(totalPoints);
        //                 int nextTierPts = GetNextTierThreshold(totalPoints);
        //                 int prevTierPts = GetCurrentTierThreshold(totalPoints);
        //                 int progress    = nextTierPts > prevTierPts
        //                                 ? (int)Math.Round((double)(totalPoints - prevTierPts)
        //                                   / (nextTierPts - prevTierPts) * 100)
        //                                 : 100;
        //
        //                 string badgeCss;
        //                 if (tier == "Gold")        badgeCss = "badge-gold";
        //                 else if (tier == "Silver") badgeCss = "badge-silver";
        //                 else                       badgeCss = "badge-bronze";
        //
        //                 lblInitials.Text    = initials.ToUpper();
        //                 lblFullName.Text    = fullName;
        //                 lblEmail.Text       = email;
        //                 lblTier.Text        = tier;
        //
        //                 badgeMember.InnerText           = string.Format("{0} Member", tier);
        //                 badgeMember.Attributes["class"] = string.Format("badge {0}", badgeCss);
        //
        //                 lblInfoName.Text    = fullName;
        //                 lblInfoPhone.Text   = phone;
        //                 lblInfoAddress.Text = address;
        //                 lblMemberSince.Text = joined.ToString("MMMM yyyy");
        //
        //                 lblPoints.Text           = string.Format("{0} pts", totalPoints);
        //                 lblNextTier.Text          = nextTierPts > totalPoints
        //                                           ? string.Format("Next tier: {0} ({1} pts)", GetTier(nextTierPts), nextTierPts)
        //                                           : "Max tier reached!";
        //                 barFill.Style["width"]   = string.Format("{0}%", progress);
        //                 lblBarMin.Text           = prevTierPts.ToString();
        //                 lblBarMax.Text           = nextTierPts.ToString();
        //                 lblCardNo.Text           = cardNo;
        //                 lblOrderCount.Text       = string.Format("{0} orders", orderCount);
        //                 lblRoyaltyBadge.Text     = tier;
        //                 lblRoyaltyBadge.CssClass = string.Format("badge {0}", badgeCss);
        //             }
        //         }
        //     }
        // }

        // private void LoadRecentOrders(int userId)
        // {
        //     using (SqlConnection con = new SqlConnection(_connStr))
        //     using (SqlCommand cmd = new SqlCommand("sp_GetRecentOrders", con))
        //     {
        //         cmd.CommandType = System.Data.CommandType.StoredProcedure;
        //         cmd.Parameters.AddWithValue("@UserID", userId);
        //         cmd.Parameters.AddWithValue("@TopN",   3);
        //         con.Open();
        //         System.Data.DataTable dt = new System.Data.DataTable();
        //         dt.Load(cmd.ExecuteReader());
        //         rptOrders.DataSource = dt;
        //         rptOrders.DataBind();
        //     }
        // }

        // ── TIER HELPERS (used by LoadProfile above) ──────────────────────────
        // private static string GetTier(int points)
        // {
        //     if (points >= 1000) return "Gold";
        //     if (points >= 500)  return "Silver";
        //     return "Bronze";
        // }
        // private static int GetCurrentTierThreshold(int points)
        // {
        //     if (points >= 1000) return 1000;
        //     if (points >= 500)  return 500;
        //     return 0;
        // }
        // private static int GetNextTierThreshold(int points)
        // {
        //     if (points >= 1000) return 1000;
        //     if (points >= 500)  return 1000;
        //     return 500;
        // }

        // ─────────────────────────────────────────────────────────────────────
        // LOG OUT
        // ─────────────────────────────────────────────────────────────────────
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}