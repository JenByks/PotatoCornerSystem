<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
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
    background: rgba(255, 165, 0, 0.12);
    z-index: 0;
}

body::before {
    top: -120px;
    left: -120px;
}

body::after {
    bottom: -120px;
    right: -120px;
}

/* ===== MAIN CARD ===== */
.about-container {
    width: 650px;
    margin: 60px auto;
    background: #ffffff;
    padding: 35px;
    border-radius: 22px;
    box-shadow: 0 25px 60px rgba(0,0,0,0.35);
    border-top: 10px solid #FFD700;
    border-left: none;
    position: relative;
    z-index: 1;
    transition: 0.3s ease;
}

/* hover lift */
.about-container:hover {
    transform: translateY(-6px);
}

/* ===== TITLE ===== */
.about-container h1 {
    color: #1FA64A;
    margin-bottom: 10px;
    font-size: 28px;
    letter-spacing: 1px;
    position: relative;
}

/* gold underline */
.about-container h1::after {
    content: "";
    display: block;
    width: 90px;
    height: 3px;
    background: #FFD700;
    margin: 10px auto 0;
    border-radius: 10px;
}

/* ===== PARAGRAPHS ===== */
.about-container p {
    color: #333;
    font-size: 15px;
    line-height: 1.7;
    margin: 12px 0;
}

/* ===== SECTION TITLES ===== */
.about-container h3 {
    color: #FFA500;
    margin-top: 25px;
    font-size: 18px;
}

/* ===== FEATURE CARDS (optional enhancement style) ===== */
.about-highlight {
    margin-top: 20px;
    padding: 15px;
    background: #fff7e6;
    border-left: 5px solid #FFA500;
    border-radius: 10px;
    color: #333;
}
    </style>
</head>
<body>

<div class="about-container">

    <h1>About Potato Corner</h1>

    <p>
        Potato Corner is the world’s most popular flavored fries brand, known for its
        signature seasoning, crispy texture, and fun snacking experience.
    </p>

    <p>
        We believe that fries are not just snacks — they are a source of happiness.
        Every serving is freshly cooked and coated with bold flavors that customers love.
    </p>

    <div class="about-highlight">
        <strong>🍟 Product Specialty:</strong> Flavored French Fries (Cheese, BBQ, Sour Cream, and more)
    </div>

    <h3>Royalty Membership System</h3>

    <p>
        Our Royalty Membership System allows customers to register and enjoy exclusive perks
        such as discounts, priority processing, and membership rewards.
    </p>

    <div class="about-highlight">
        <strong>👑 Member Benefits:</strong>
        <br>• Discounted fries purchases
        <br>• Faster order processing
        <br>• Exclusive promotions and rewards
    </div>

    <h3>Mission</h3>
    <p>To deliver fun, flavorful, and affordable snack experiences to everyone.</p>

    <h3>Vision</h3>
    <p>To be the global leader in flavored fries and snacking innovation.</p>

    <h3>Customer Experience</h3>
    <p>
        We aim to create a joyful and interactive snacking culture where every bite brings
        satisfaction and excitement.
    </p>

</div>

</body>
</html>