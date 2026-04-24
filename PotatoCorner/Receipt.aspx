<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="PotCor.Receipt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Potato Corner - Receipt</title>
    <style type="text/css">
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; }

        .navbar {
            background-color: #119247;
            padding: 10px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 5px solid #f5c800;
        }
        .navbar-logo img { height: 70px; }
        .navbar-links { display: flex; gap: 30px; list-style: none; align-items: center; }
        .navbar-links a { color: white; text-decoration: none; font-size: 15px; font-weight: bold; }
        .navbar-links a:hover { color: #f5c800; }

        .page-title {
            background-color: #119247;
            color: white;
            text-align: center;
            padding: 24px;
            font-size: 26px;
            font-weight: 900;
            text-transform: uppercase;
        }

        .receipt-wrapper {
            max-width: 620px;
            margin: 40px auto 60px;
            padding: 0 20px;
        }

        .receipt-box {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 14px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .receipt-header {
            background-color: #119247;
            color: white;
            text-align: center;
            padding: 30px 20px 20px;
        }

        .receipt-header img { height: 70px; margin-bottom: 10px; }

        .receipt-header h2 {
            font-size: 22px;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .receipt-header p { font-size: 13px; color: #cce8d8; margin-top: 4px; }

        .receipt-body { padding: 30px; }

        .section-label {
            font-size: 12px;
            font-weight: 900;
            color: #119247;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
            margin-top: 24px;
            border-bottom: 1px solid #f5c800;
            padding-bottom: 4px;
        }

        .section-label:first-child { margin-top: 0; }

        .info-row {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            padding: 5px 0;
            color: #333;
        }

        .info-row span:first-child { color: #888; }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            margin-top: 8px;
        }

        .items-table th {
            background-color: #f5c800;
            color: #333;
            padding: 8px 10px;
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
        }

        .items-table td {
            padding: 9px 10px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
        }

        .totals-section {
            background-color: #f9f9f9;
            border-radius: 8px;
            padding: 16px 20px;
            margin-top: 20px;
            font-size: 14px;
            line-height: 2;
        }

        .totals-section .grand-total {
            font-size: 18px;
            font-weight: 900;
            color: #119247;
            border-top: 2px solid #f5c800;
            padding-top: 8px;
            margin-top: 4px;
            display: flex;
            justify-content: space-between;
        }

        .totals-row {
            display: flex;
            justify-content: space-between;
            color: #555;
        }

        .royalty-badge {
            display: inline-block;
            background-color: #f5c800;
            color: #333;
            font-size: 12px;
            font-weight: bold;
            padding: 4px 12px;
            border-radius: 20px;
            margin-top: 6px;
        }

        .receipt-footer {
            background-color: #119247;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 13px;
            border-top: 4px solid #f5c800;
        }

        .receipt-footer p { margin: 4px 0; }

        .btn-row {
            display: flex;
            gap: 14px;
            margin-top: 30px;
        }

        .btn-home {
            flex: 1;
            background-color: #119247;
            color: white;
            border: none;
            padding: 14px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            text-transform: uppercase;
        }

        .btn-home:hover { background-color: #0a6b34; }

        .btn-print {
            flex: 1;
            background-color: #f5c800;
            color: #333;
            border: none;
            padding: 14px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            text-transform: uppercase;
        }

        .btn-print:hover { background-color: #e0b800; }

        @media print {
            .btn-row, .navbar, .page-title { display: none; }
            body { background: white; }
            .receipt-wrapper { margin: 0; max-width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <div class="navbar-logo"><img src="logopotcor.png" alt="Potato Corner" /></div>
            <ul class="navbar-links">
                <li><a href="Default.aspx">Home</a></li>
                <li><a href="Order.aspx">Order Again</a></li>
            </ul>
        </div>

        <div class="page-title">Order Receipt</div>

        <div class="receipt-wrapper">
            <div class="receipt-box">

                <div class="receipt-header">
                    <img src="logopotcor.png" alt="Potato Corner" />
                    <h2>Thank You For Your Order!</h2>
                    <p>Order #<asp:Label ID="lblOrderNo" runat="server"></asp:Label> &nbsp;|&nbsp; <asp:Label ID="lblOrderDate" runat="server"></asp:Label></p>
                </div>

                <div class="receipt-body">

                    <div class="section-label">Customer Details</div>
                    <div class="info-row"><span>Name</span><span><asp:Label ID="lblName" runat="server"></asp:Label></span></div>
                    <div class="info-row"><span>Address</span><span><asp:Label ID="lblAddress" runat="server"></asp:Label></span></div>
                    <div class="info-row"><span>Contact</span><span><asp:Label ID="lblContact" runat="server"></asp:Label></span></div>
                    <div class="info-row"><span>Delivery Type</span><span><asp:Label ID="lblDelivery" runat="server"></asp:Label></span></div>

                    <div class="section-label">Royalty Membership</div>
                    <asp:Panel ID="pnlRoyalty" runat="server">
                        <div class="info-row"><span>Royalty No.</span><span><asp:Label ID="lblRoyaltyNo" runat="server"></asp:Label></span></div>
                        <span class="royalty-badge">✓ Royalty Member — 10% Discount Applied</span>
                    </asp:Panel>
                    <asp:Panel ID="pnlNoRoyalty" runat="server" Visible="false">
                        <div class="info-row"><span style="color:#aaa;">Not a royalty member</span></div>
                    </asp:Panel>

                    <div class="section-label">Payment Details</div>
                    <div class="info-row"><span>Payment Method</span><span><asp:Label ID="lblPaymentMethod" runat="server"></asp:Label></span></div>
                    <div class="info-row"><span>Amount Paid</span><span>₱<asp:Label ID="lblAmountPaid" runat="server"></asp:Label></span></div>
                    <div class="info-row"><span>Change</span><span>₱<asp:Label ID="lblChange" runat="server"></asp:Label></span></div>

                    <div class="section-label">Points Earned</div>
                    <div class="info-row">
                        <span>Points from this order</span>
                        <span><strong style="color:#119247;"><asp:Label ID="lblPointsEarned" runat="server"></asp:Label> pts</strong></span>
                    </div>
                    <div style="font-size:12px;color:#aaa;margin-top:4px;">Every ₱500 spent = 2 points</div>

                    <div class="section-label">Order Items</div>
                    <table class="items-table">
                        <tr>
                            <th>Product</th>
                            <th>Size</th>
                            <th>Flavor</th>
                            <th>Qty</th>
                            <th>Price</th>
                        </tr>
                        <asp:Repeater ID="rptItems" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("Product") %></td>
                                    <td><%# Eval("Size") %></td>
                                    <td><%# Eval("Flavor") %></td>
                                    <td><%# Eval("Qty") %></td>
                                    <td>₱<%# Eval("LineTotal", "{0:0.00}") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>

                    <div class="totals-section">
                        <div class="totals-row"><span>Subtotal</span><span>₱<asp:Label ID="lblSubtotal" runat="server"></asp:Label></span></div>
                        <div class="totals-row"><span>Royalty Discount</span><span>-₱<asp:Label ID="lblDiscount" runat="server"></asp:Label></span></div>
                        <div class="totals-row"><span>Delivery Fee</span><span>+₱<asp:Label ID="lblDeliveryFee" runat="server"></asp:Label></span></div>
                        <div class="grand-total"><span>TOTAL</span><span>₱<asp:Label ID="lblTotal" runat="server"></asp:Label></span></div>
                    </div>

                </div>

                <div class="receipt-footer">
                    <p>Thank you for choosing Potato Corner!</p>
                    <p>#FlavorTheMoment</p>
                </div>

            </div>

            <div class="btn-row">
                <asp:Button ID="btnHome" runat="server" Text="Back to Home" CssClass="btn-home" OnClick="btnHome_Click" />
                <button type="button" class="btn-print" onclick="window.print()">Print Receipt</button>
            </div>
        </div>

    </form>
</body>
</html>
