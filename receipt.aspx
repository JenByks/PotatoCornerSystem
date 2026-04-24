<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="receipt.aspx.cs" Inherits="PotatoCorner.receipt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Receipt</title>
    <style>
        /* ===== BACKGROUND ===== */
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
    background: linear-gradient(135deg, #0f5e2d, #1FA64A);
    overflow-x: hidden;
}

/* decorative glow */
body::before,
body::after {
    content: "";
    position: fixed;
    width: 280px;
    height: 280px;
    border-radius: 50%;
    background: rgba(255, 215, 0, 0.12);
    z-index: 0;
}

body::before {
    top: -100px;
    left: -100px;
}

body::after {
    bottom: -120px;
    right: -120px;
}

/* ===== RECEIPT CARD ===== */
.receipt {
    width: 430px;
    margin: 60px auto;
    background: #ffffff;
    padding: 30px 25px;
    border-radius: 20px;
    box-shadow: 0 25px 60px rgba(0,0,0,0.35);
    text-align: center;
    border-top: 10px solid #FFD700;
    position: relative;
    z-index: 1;
    transition: 0.3s ease;
}

/* hover lift */
.receipt:hover {
    transform: translateY(-6px);
}

/* ===== TITLE ===== */
.receipt h2 {
    color: #1FA64A;
    margin-bottom: 15px;
    font-size: 22px;
    letter-spacing: 1px;
    position: relative;
}

/* gold underline */
.receipt h2::after {
    content: "";
    display: block;
    width: 90px;
    height: 3px;
    background: #FFD700;
    margin: 8px auto 0;
    border-radius: 10px;
}

/* ===== USER IMAGE ===== */
.receipt img {
    width: 130px;
    height: 130px;
    object-fit: cover;
    border-radius: 50%;
    border: 5px solid #FFD700;
    margin: 15px 0;
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
    transition: 0.3s ease;
}

/* image hover */
.receipt img:hover {
    transform: scale(1.05);
}

/* ===== TEXT INFO ===== */
.receipt p {
    margin: 8px 0;
    font-size: 15px;
    color: #333;
}

/* labels */
.receipt strong {
    color: #1FA64A;
}

/* ===== FEE SECTION ===== */
.receipt h3 {
    margin-top: 20px;
    padding: 12px;
    background: linear-gradient(135deg, #fff7e6, #ffffff);
    border: 2px dashed #FFD700;
    border-radius: 12px;
    color: #1FA64A;
    font-size: 18px;
    letter-spacing: 0.5px;
}

/* ===== OPTIONAL FOOTER DECOR ===== */
.receipt::after {
    content: "ROYAL MEMBER RECEIPT";
    position: absolute;
    bottom: 10px;
    left: 50%;
    transform: translateX(-50%);
    font-size: 10px;
    color: #aaa;
    letter-spacing: 2px;
}
    </style>
</head>
<body>

<div class="receipt">
    <h2>Registration Receipt</h2>

    <asp:Image ID="imgUser" runat="server" />

    <p><strong>Name:</strong> <asp:Label ID="lblName" runat="server" /></p>
    <p><strong>Address:</strong> <asp:Label ID="lblAddress" runat="server" /></p>
    <p><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
    <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" /></p>

    <h3>Fee Paid: ₱100</h3>
</div>

</body>
</html>