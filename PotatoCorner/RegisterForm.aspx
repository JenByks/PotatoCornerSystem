<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="PotCor.RegisterForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Potato Corner - Membership Registration</title>
    <style type="text/css">
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(135deg, #119247 0%, #0d7336 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        .logo {
            text-align: center;
            margin-bottom: 15px;
        }

        .logo img {
            height: 70px;
            filter: drop-shadow(0 4px 10px rgba(0,0,0,0.3));
        }

        .form-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
        }

        .form-title {
            font-size: 24px;
            color: #119247;
            font-weight: 900;
            text-align: center;
            margin-bottom: 5px;
            text-transform: uppercase;
        }

        .form-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 15px;
            font-size: 13px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 12px;
            margin-bottom: 15px;
        }

        .form-group {
            margin-bottom: 0;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group.two-col {
            grid-column: span 2;
        }

        .form-label {
            display: block;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
            font-size: 12px;
        }

        .form-input {
            width: 100%;
            padding: 8px 10px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 13px;
            transition: all 0.3s;
        }

        .form-input:focus {
            border-color: #119247;
            outline: none;
            box-shadow: 0 0 0 3px rgba(17,146,71,0.1);
        }

        .upload-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e8f5ee 100%);
            border: 2px dashed #119247;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
        }

        .upload-icon {
            font-size: 28px;
            color: #119247;
            margin-bottom: 5px;
        }

        .upload-text {
            color: #666;
            font-size: 11px;
            margin-bottom: 8px;
        }

        .file-upload {
            display: inline-block;
            padding: 6px 14px;
            background: #119247;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 700;
            font-size: 12px;
            transition: all 0.3s;
        }

        .file-upload:hover {
            background: #0d7336;
        }

        .fee-section {
            background: linear-gradient(135deg, #fffbf0 0%, #fff3e0 100%);
            border: 2px solid #f5c800;
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 12px;
            text-align: center;
        }

        .fee-label {
            font-size: 12px;
            color: #666;
            margin-bottom: 2px;
        }

        .fee-amount {
            font-size: 24px;
            color: #e8401c;
            font-weight: 900;
        }

        .payment-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
            margin-top: 6px;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #e8401c 0%, #c73516 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 900;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(232,64,28,0.4);
            letter-spacing: 1px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(232,64,28,0.5);
        }

        .login-link {
            text-align: center;
            margin-top: 12px;
            color: white;
            font-size: 13px;
        }

        .login-link a {
            color: #f5c800;
            text-decoration: none;
            font-weight: 700;
        }

        .error-msg {
            background: #f8d7da;
            color: #721c24;
            padding: 8px;
            border-radius: 6px;
            margin-bottom: 12px;
            border-left: 3px solid #dc3545;
            font-size: 12px;
        }

        .payment-btn {
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            background: white;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .payment-btn:hover {
            border-color: #119247;
            background: #e8f5ee;
        }

        .payment-btn.selected {
            border-color: #119247;
            background: linear-gradient(135deg, #e8f5ee 0%, #d4edda 100%);
            color: #119247;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="logo">
                <img src="logopotcor.png" alt="Potato Corner" />
            </div>

            <div class="form-card">
                <h1 class="form-title">Membership Registration</h1>
                <p class="form-subtitle">Join our Royalty Program and enjoy exclusive benefits!</p>

                <asp:Label ID="lblMessage" runat="server" CssClass="error-msg" Visible="false"></asp:Label>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">First Name <span class="required">*</span></label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-input" placeholder="First name"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Last Name <span class="required">*</span></label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-input" placeholder="Last name"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Date of Birth <span class="required">*</span></label>
                        <asp:TextBox ID="txtBirthDate" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="form-group two-col">
                        <label class="form-label">Email Address <span class="required">*</span></label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" TextMode="Email" placeholder="email@example.com"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Contact Number <span class="required">*</span></label>
                        <asp:TextBox ID="txtContact" runat="server" CssClass="form-input" placeholder="09XX XXX XXXX"></asp:TextBox>
                    </div>

                    <div class="form-group two-col">
                        <label class="form-label">Complete Address <span class="required">*</span></label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" placeholder="Street, Barangay, City, Province"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Upload Photo <span class="required">*</span></label>
                        <div class="upload-section">
                            <div class="upload-icon">📷</div>
                            <asp:FileUpload ID="fileUploadPicture" runat="server" CssClass="file-upload" accept=".png,.jpg,.jpeg" />
                        </div>
                    </div>
                </div>

                <div class="fee-section">
                    <div class="fee-label">Registration Fee</div>
                    <div class="fee-amount">PHP 100</div>
                </div>

                <div class="form-group">
                    <label class="form-label">Payment Method <span class="required">*</span></label>
                    <div class="payment-grid">
                        <asp:Button ID="btnGoTyme" runat="server" Text="GoTyme" CssClass="payment-btn" OnClick="btnPaymentMethod_Click" CausesValidation="false" />
                        <asp:Button ID="btnMayaBank" runat="server" Text="Maya" CssClass="payment-btn" OnClick="btnPaymentMethod_Click" CausesValidation="false" />
                        <asp:Button ID="btnGCash" runat="server" Text="GCash" CssClass="payment-btn" OnClick="btnPaymentMethod_Click" CausesValidation="false" />
                        <asp:Button ID="btnPoints" runat="server" Text="Points" CssClass="payment-btn" OnClick="btnPaymentMethod_Click" CausesValidation="false" />
                    </div>
                    <asp:HiddenField ID="hdnPaymentMethod" runat="server" Value="" />
                </div>

                <div class="form-group">
                    <label class="form-label">Amount Paid <span class="required">*</span></label>
                    <asp:TextBox ID="txtAmountPaid" runat="server" CssClass="form-input" placeholder="Enter amount (minimum PHP 100)" TextMode="Number"></asp:TextBox>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnRegister_Click" />

                <div class="login-link">
                    Already have an account? <a href="Login.aspx">Login here</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
