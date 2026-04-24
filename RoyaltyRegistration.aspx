<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RoyaltyRegistration.aspx.cs" Inherits="PotatoCorner.RoyaltyRegistration" %>

<!DOCTYPE html>
<html>
<head>
    <title>Royalty Registration</title>
    <style>
      /* ===== BACKGROUND ===== */
body {
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
    background: radial-gradient(circle at top, #1FA64A, #0f5e2d);
    overflow-x: hidden;
}

/* glowing decorative circles */
body::before,
body::after {
    content: "";
    position: fixed;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    background: rgba(255, 215, 0, 0.15);
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

/* ===== CENTER WRAPPER ===== */
.form-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* ===== MAIN CARD ===== */
.form-container {
    width: 440px;
    background: #ffffff;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 25px 60px rgba(0,0,0,0.35);
    border-top: 8px solid #FFD700;
    position: relative;
    z-index: 1;
    transition: 0.3s ease;
}

/* hover lift */
.form-container:hover {
    transform: translateY(-6px);
}

/* ===== TITLE ===== */
.form-container h2 {
    text-align: center;
    color: #1FA64A;
    margin-bottom: 25px;
    font-size: 22px;
    letter-spacing: 1px;
    position: relative;
}

/* gold underline accent */
.form-container h2::after {
    content: "";
    width: 80px;
    height: 3px;
    background: #FFD700;
    display: block;
    margin: 8px auto 0;
    border-radius: 10px;
}

/* ===== LABELS ===== */
label {
    font-weight: 600;
    color: #333;
    display: block;
    margin-top: 12px;
    font-size: 13px;
}

/* ===== INPUTS ===== */
input[type="text"],
input[type="email"],
input[type="file"],
textarea,
select {
    width: 100%;
    padding: 11px 12px;
    margin-top: 6px;
    border-radius: 12px;
    border: 1px solid #ddd;
    background: #fafafa;
    font-size: 14px;
    transition: 0.3s;
}

/* focus glow */
input:focus {
    border-color: #FFD700;
    box-shadow: 0 0 10px rgba(255, 215, 0, 0.4);
    outline: none;
    background: #fff;
}

/* ===== FEE BOX SPECIAL ===== */
#txtFee {
    background: linear-gradient(135deg, #fffbe6, #ffffff);
    font-weight: bold;
    color: #1FA64A;
    text-align: center;
    border: 2px dashed #FFD700;
}

/* ===== BUTTON ===== */
button, .aspNetButton {
    width: 100%;
    padding: 13px;
    margin-top: 18px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, #FFD700, #FFA500);
    color: #2c2c2c;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

/* hover effect */
button:hover, .aspNetButton:hover {
    transform: scale(1.04);
    box-shadow: 0 10px 25px rgba(0,0,0,0.25);
}

/* click effect */
button:active {
    transform: scale(0.98);
}

/* shine animation */
button::after {
    content: "";
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: rgba(255,255,255,0.3);
    transform: skewX(-20deg);
}

button:hover::after {
    animation: shine 0.7s ease forwards;
}

@keyframes shine {
    100% {
        left: 120%;
    }
}

/* ===== OPTIONAL IMAGE PREVIEW ===== */
.preview-img {
    display: block;
    margin: 12px auto;
    width: 120px;
    border-radius: 50%;
    border: 4px solid #FFD700;
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
}
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="form-wrapper">
    <div class="form-container">
    <h2>Royalty Registration</h2>

    Name:
    <asp:TextBox ID="txtName" runat="server" />

    Address:
    <asp:TextBox ID="txtAddress" runat="server" />

    Phone:
    <asp:TextBox ID="txtPhone" runat="server" />

    Email:
    <asp:TextBox ID="txtEmail" runat="server" />

    Upload Picture:
    <asp:FileUpload ID="fileUpload" runat="server" />

    Registration Fee:
    <asp:TextBox ID="txtFee" runat="server" Text="100" ReadOnly="true" />

    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
</div>
    </div>
</form>

</body>
</html>