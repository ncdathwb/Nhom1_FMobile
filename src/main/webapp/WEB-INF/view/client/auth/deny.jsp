<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error 403 - Forbidden</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            text-align: center;
            padding: 50px;
        }
        .error-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 500px;
            margin: 0 auto;
        }
        .error-title {
            font-size: 72px;
            font-weight: bold;
            color: #dc3545;
        }
        .error-message {
            font-size: 24px;
            margin: 20px 0;
        }
        .home-link {
            font-size: 18px;
            color: #007bff;
            text-decoration: none;
        }
        .home-link:hover {
            text-decoration: underline;
        }
        .error-icon {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
        }
        body {
            background: url("https://media.istockphoto.com/id/1364145374/vi/anh/n%E1%BB%81n-m%C3%A0u-h%E1%BB%93ng.jpg?s=612x612&w=0&k=20&c=BdbrGWaRrTlwN7vrJ14Dm4L_4V4chkSdN6cU__ha8_4=");
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body>

<div class="error-container">
    <img src="https://cdn-icons-png.flaticon.com/512/564/564619.png" alt="Error Icon" class="error-icon">
    <div class="error-title">403</div>
    <div class="error-message">Access Denied!</div>
    <p>You do not have permission to access this resource. Please contact your administrator if you believe this is an error.</p>
    <a href="/" class="home-link">Go back to Home</a>
</div>

</body>
</html>
