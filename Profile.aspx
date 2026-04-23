<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="PotCor.Profile" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Potato Corner - Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@400;500&display=swap" rel="stylesheet" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        html, body {
            height: 100%;
            overflow: hidden;
        }

        body {
            height: 100vh;
            background-color: #0d7a3a;
            background-image:
                radial-gradient(circle at 20% 20%, rgba(255,255,255,0.06) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(0,0,0,0.15) 0%, transparent 50%);
            font-family: 'DM Sans', sans-serif;
            display: flex;
            flex-direction: column;
            padding: 16px;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: radial-gradient(circle, rgba(255,255,255,0.08) 1px, transparent 1px);
            background-size: 28px 28px;
            pointer-events: none;
            z-index: 0;
        }

        /* ── TOP NAV ── */
        .topnav {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 12px;
            flex-shrink: 0;
        }

        .nav-logo { font-family: 'DM Sans', sans-serif; font-weight: 800; font-size: 18px; color: #ffffff; letter-spacing: -0.5px; }
        .nav-logo span { color: #fac775; }

        .nav-back {
            font-size: 12px;
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: color 0.2s;
        }
        .nav-back:hover { color: #ffffff; }

        /* ── FORM fills remaining height ── */
        form {
            flex: 1;
            display: flex;
            flex-direction: column;
            min-height: 0;
            position: relative;
            z-index: 1;
        }

        /* ── TWO-COLUMN GRID ── */
        .profile-grid {
            flex: 1;
            display: grid;
            grid-template-columns: 210px 1fr;
            gap: 10px;
            min-height: 0;
        }

        /* ── SHARED CARD ── */
        .card {
            background: rgba(255,255,255,0.97);
            border-radius: 16px;
            box-shadow: 0 2px 0px rgba(255,255,255,0.4) inset, 0 12px 32px rgba(0,0,0,0.18);
            overflow: hidden;
            animation: floatIn 0.5s ease both;
        }

        /* ── LEFT COLUMN ── */
        .col-left {
            display: flex;
            flex-direction: column;
            gap: 10px;
            min-height: 0;
        }

        .menu-card { flex: 1; }

        /* ── AVATAR ── */
        .avatar-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 8px;
            padding: 20px 16px 16px;
        }

        .avatar-ring { position: relative; display: inline-block; }

        .avatar-circle {
            width: 70px; height: 70px;
            border-radius: 50%;
            background: #f0faf4;
            border: 3px solid #fac775;
            display: flex; align-items: center; justify-content: center;
            font-family: 'DM Sans', sans-serif;
            font-weight: 800; font-size: 24px;
            color: #0d4a22;
        }

        .avatar-dot {
            position: absolute; bottom: 3px; right: 3px;
            width: 14px; height: 14px;
            background: #119247;
            border-radius: 50%;
            border: 2px solid #fff;
        }

        .avatar-name {
            font-family: 'DM Sans', sans-serif;
            font-weight: 800; font-size: 14px;
            color: #0d4a22; text-align: center; line-height: 1.2;
        }

        .avatar-email { font-size: 11px; color: #6b8f77; text-align: center; }

        .badge-strip { display: flex; gap: 5px; flex-wrap: wrap; justify-content: center; }

        .badge { font-size: 10px; font-weight: 500; padding: 3px 9px; border-radius: 20px; border: 1px solid; }
        .badge-bronze { background: #faeeda; color: #633806; border-color: #fac775; }
        .badge-silver { background: #f0f4fa; color: #3a4a5c; border-color: #b0c4d8; }
        .badge-gold   { background: #fffbe6; color: #7a5a00; border-color: #f5d060; }
        .badge-green  { background: #f0faf4; color: #3a5c45; border-color: #c8e6d0; }

        /* ── MENU ── */
        .menu-card .menu-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 13px 18px;
            border-bottom: 1px solid #e8f2ec;
            cursor: pointer; transition: background 0.15s;
            font-size: 13px; color: #1a2e22; text-decoration: none;
        }
        .menu-card .menu-row:last-child { border-bottom: none; }
        .menu-card .menu-row:hover { background: #f4f9f6; }
        .menu-row-danger { color: #c0392b !important; }
        .chevron { font-size: 15px; color: #a8c4b2; }

        /* ── RIGHT COLUMN ── */
        .col-right {
            display: flex;
            flex-direction: column;
            gap: 10px;
            min-height: 0;
        }

        .card-body { padding: 14px 18px; }

        .section-heading {
            font-family: 'DM Sans', sans-serif;
            font-weight: 700; font-size: 13px;
            color: #0d4a22; margin-bottom: 10px;
            display: flex; align-items: center; justify-content: space-between;
        }

        .edit-btn {
            font-size: 11px; font-family: 'DM Sans', sans-serif; font-weight: 500;
            color: #119247; background: #f0faf4;
            border: 1px solid #c8e6d0; border-radius: 8px;
            padding: 3px 10px; cursor: pointer;
            transition: background 0.2s; text-decoration: none;
        }
        .edit-btn:hover { background: #e0f5e8; }

        /* ── PERSONAL INFO ── */
        .info-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 7px 0; border-bottom: 1px solid #e8f2ec;
        }
        .info-row:last-child { border-bottom: none; }
        .info-label { color: #6b8f77; font-size: 12px; }
        .info-value { color: #1a2e22; font-size: 12px; font-weight: 500; text-align: right; max-width: 60%; }

        /* ── ROYALTY ── */
        .points-bar-wrap { background: #f4f9f6; border-radius: 10px; padding: 11px; margin-bottom: 10px; }

        .points-top { display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 7px; }

        .points-number { font-family: 'DM Sans', sans-serif; font-weight: 800; font-size: 20px; color: #0d4a22; letter-spacing: -0.5px; }
        .points-label  { font-size: 11px; color: #6b8f77; }
        .points-next   { font-size: 11px; color: #6b8f77; }

        .bar-track { background: #d0e6d8; border-radius: 99px; height: 6px; overflow: hidden; }
        .bar-fill  { height: 100%; background: linear-gradient(90deg, #119247, #fac775); border-radius: 99px; }

        .bar-labels { display: flex; justify-content: space-between; margin-top: 4px; }
        .bar-labels span { font-size: 10px; color: #a8c4b2; }

        .royalty-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }

        .royalty-stat { background: #f4f9f6; border-radius: 10px; padding: 10px; text-align: center; }
        .royalty-stat-label { font-size: 10px; color: #6b8f77; margin-bottom: 3px; text-transform: uppercase; letter-spacing: 0.4px; }
        .royalty-stat-value { font-family: 'Syne', sans-serif; font-weight: 700; font-size: 13px; color: #0d4a22; }

        /* ── RECENT ORDERS ── */
        .orders-card {
            flex: 1;
            min-height: 0;
            display: flex;
            flex-direction: column;
        }

        .orders-card .card-body {
            flex: 1;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .order-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 8px 0; border-bottom: 1px solid #e8f2ec;
        }
        .order-row:last-child { border-bottom: none; }
        .order-id   { font-family: 'DM Sans', sans-serif; font-weight: 700; font-size: 12px; color: #0d4a22; margin-bottom: 2px; }
        .order-meta { font-size: 11px; color: #6b8f77; }

        .status-badge     { font-size: 10px; font-weight: 500; padding: 3px 9px; border-radius: 20px; white-space: nowrap; }
        .status-delivered { background: #f0faf4; color: #3a5c45; border: 1px solid #c8e6d0; }
        .status-ontheway  { background: #faeeda; color: #633806; border: 1px solid #fac775; }
        .status-pending   { background: #fff0f0; color: #7a1f1f; border: 1px solid #f5c6c6; }

        @keyframes floatIn {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .col-left  .card:nth-child(1) { animation-delay: 0.05s; }
        .col-left  .card:nth-child(2) { animation-delay: 0.10s; }
        .col-right .card:nth-child(1) { animation-delay: 0.12s; }
        .col-right .card:nth-child(2) { animation-delay: 0.18s; }
        .col-right .card:nth-child(3) { animation-delay: 0.24s; }
    </style>
</head>
<body>

    <!-- TOP NAV -->
    <div class="topnav">
        <div class="nav-logo">🥔 Potato<span>Corner</span></div>
        <a href="Home.aspx" class="nav-back">&#8592; Back to Home</a>
    </div>

    <form id="form1" runat="server">
        <div class="profile-grid">

            <!-- ── LEFT COLUMN ── -->
            <div class="col-left">

                <!-- 1. AVATAR CARD -->
                <div class="card">
                    <div class="avatar-card">
                        <div class="avatar-ring">
                            <div class="avatar-circle">
                                <asp:Label ID="lblInitials" runat="server" Text="?" />
                            </div>
                            <div class="avatar-dot"></div>
                        </div>
                        <div>
                            <p class="avatar-name">
                                <asp:Label ID="lblFullName" runat="server" Text="" />
                            </p>
                            <p class="avatar-email">
                                <asp:Label ID="lblEmail" runat="server" Text="" />
                            </p>
                        </div>
                        <div class="badge-strip">
                            <span id="badgeMember" runat="server" class="badge badge-bronze">Bronze Member</span>
                            <span class="badge badge-green">Customer</span>
                        </div>
                        <asp:Label ID="lblTier" runat="server" Text="" Style="display:none;" />
                    </div>
                </div>

                <!-- 2. ACCOUNT MENU -->
                <div class="card menu-card">
                    <a href="Settings.aspx" class="menu-row">
                        Account settings
                        <span class="chevron">&#8250;</span>
                    </a>
                    <a href="OrderHistory.aspx" class="menu-row">
                        Order history
                        <span class="chevron">&#8250;</span>
                    </a>
                    <a href="AboutUs.aspx" class="menu-row">
                        About us
                        <span class="chevron">&#8250;</span>
                    </a>
                    <asp:LinkButton ID="btnLogout" runat="server"
                        CssClass="menu-row menu-row-danger"
                        OnClick="btnLogout_Click">
                        Log out
                        <span class="chevron">&#8250;</span>
                    </asp:LinkButton>
                </div>

            </div>

            <!-- ── RIGHT COLUMN ── -->
            <div class="col-right">

                <!-- 3. PERSONAL INFORMATION -->
                <div class="card">
                    <div class="card-body">
                        <div class="section-heading">
                            Personal information
                            <a href="EditProfile.aspx" class="edit-btn">Edit</a>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Full name</span>
                            <span class="info-value"><asp:Label ID="lblInfoName" runat="server" Text="" /></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Phone</span>
                            <span class="info-value"><asp:Label ID="lblInfoPhone" runat="server" Text="" /></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Address</span>
                            <span class="info-value"><asp:Label ID="lblInfoAddress" runat="server" Text="" /></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Member since</span>
                            <span class="info-value"><asp:Label ID="lblMemberSince" runat="server" Text="" /></span>
                        </div>
                    </div>
                </div>

                <!-- 4. ROYALTY CARD -->
                <div class="card">
                    <div class="card-body">
                        <div class="section-heading">
                            Royalty card
                            <asp:Label ID="lblRoyaltyBadge" runat="server" Text="Bronze" CssClass="badge badge-bronze" />
                        </div>
                        <div class="points-bar-wrap">
                            <div class="points-top">
                                <div>
                                    <div class="points-number">
                                        <asp:Label ID="lblPoints" runat="server" Text="0 pts" />
                                    </div>
                                    <div class="points-label">Total points</div>
                                </div>
                                <div class="points-next">
                                    <asp:Label ID="lblNextTier" runat="server" Text="" />
                                </div>
                            </div>
                            <div class="bar-track">
                                <div id="barFill" runat="server" class="bar-fill" style="width:0%;"></div>
                            </div>
                            <div class="bar-labels">
                                <span><asp:Label ID="lblBarMin" runat="server" Text="0" /></span>
                                <span><asp:Label ID="lblBarMax" runat="server" Text="500" /></span>
                            </div>
                        </div>
                        <div class="royalty-grid">
                            <div class="royalty-stat">
                                <div class="royalty-stat-label">Card number</div>
                                <div class="royalty-stat-value"><asp:Label ID="lblCardNo" runat="server" Text="" /></div>
                            </div>
                            <div class="royalty-stat">
                                <div class="royalty-stat-label">Orders placed</div>
                                <div class="royalty-stat-value"><asp:Label ID="lblOrderCount" runat="server" Text="" /></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 5. RECENT ORDERS -->
                <div class="card orders-card">
                    <div class="card-body">
                        <div class="section-heading">Recent orders</div>
                        <asp:Repeater ID="rptOrders" runat="server">
                            <ItemTemplate>
                                <div class="order-row">
                                    <div>
                                        <div class="order-id"><%# Eval("OrderCode") %></div>
                                        <div class="order-meta">
                                            <%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy") %>
                                            &middot;
                                            <%# Eval("OrderSummary") %>
                                        </div>
                                    </div>
                                    <span class='<%# Eval("Status").ToString() == "Delivered" ? "status-badge status-delivered" : Eval("Status").ToString() == "On the way" ? "status-badge status-ontheway" : "status-badge status-pending" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

            </div>
            <!-- end col-right -->

        </div>
    </form>

</body>
</html>
