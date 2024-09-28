<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<!-- Created By CodingNepal -->
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Register | FMOBILE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        html,body{
            display: grid;
            height: 100%;
            width: 100%;
            place-items: center;
            background: #f2f2f2;
            background: url("https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg");
        }
        ::selection{
            background: #4158d0;
            color: #fff;
        }
        .wrapper{
            width: 600px;
            background: rgba(255, 255, 255, 0.84);
            border-radius: 15px;
            box-shadow: 0px 15px 20px rgba(0,0,0,0.1);
        }
        .wrapper .title{
            font-size: 35px;
            font-weight: 600;
            text-align: center;
            line-height: 100px;
            color: #fff;
            user-select: none;
            border-radius: 15px 15px 0 0;
            background: linear-gradient(-135deg, #409a15, #223e21);
        }
        .wrapper form{
            padding: 10px 30px 50px 30px;
        }
        .wrapper form .field{
            height: 50px;
            width: 100%;
            margin-top: 20px;
            position: relative;
        }
        .wrapper form .field input{
            height: 100%;
            width: 100%;
            outline: none;
            font-size: 17px;
            padding-left: 20px;
            border: 1px solid #68d041;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .wrapper form .field input:focus,
        form .field input:valid{
            border-color: #68d041;
        }
        .wrapper form .field label{
            position: absolute;
            top: 50%;
            left: 20px;
            color: #999999;
            font-weight: 400;
            font-size: 17px;
            pointer-events: none;
            transform: translateY(-50%);
            transition: all 0.3s ease;
        }
        form .field input:focus ~ label,
        form .field input:valid ~ label{
            top: 0%;
            font-size: 16px;
            color: #4158d0;
            background: #fff;
            transform: translateY(-50%);
        }
        form .content{
            display: flex;
            width: 100%;
            height: 50px;
            font-size: 16px;
            align-items: center;
            justify-content: space-around;
        }
        form .content .checkbox{
            display: flex;
            align-items: center;
            justify-content: center;
        }
        form .content input{
            width: 15px;
            height: 15px;
            background: red;
        }
        form .content label{
            color: #262626;
            user-select: none;
            padding-left: 5px;
        }
        form .content .pass-link{
            /*color: "";*/
        }
        form .field input[type="submit"]{
            color: #fff;
            border: none;
            padding-left: 0;
            margin-top: -10px;
            font-size: 20px;
            font-weight: 500;
            cursor: pointer;
            background: linear-gradient(-135deg, #409a15, #223e21);
            transition: all 0.3s ease;
        }
        form .field input[type="submit"]:active{
            transform: scale(0.95);
        }
        form .signup-link{
            color: #262626;
            margin-top: 20px;
            text-align: center;
        }
        form .pass-link a,
        form .signup-link a{
            color: #4158d0;
            text-decoration: none;
        }
        form .pass-link a:hover,
        form .signup-link a:hover{
            text-decoration: underline;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="title">Register</div>

    <%--@elvariable id="register" type="com.group1.fmobile.domain.dto.RegisterDTO"--%>
    <form:form action="/register" method="post" modelAttribute="register">
        <div class="mb-5 field">
            <form:input path="fullName" type="text" required="required" />
            <label for="fullName">Full Name</label>
            <!-- Hiển thị lỗi cho fullName -->
            <form:errors path="fullName" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:input path="email" type="text" required="required" />
            <label for="email">Email Address</label>

            <form:errors path="email" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:input path="phone" type="number" required="required" />
            <label for="phone">Phone Number</label>

            <form:errors path="phone" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:input path="address" type="text" required="required" />
            <label for="address">Address</label>

            <form:errors path="address" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:password path="password" required="required" />
            <label for="password">Password</label>

            <form:errors path="password" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:password path="confirmPassword" required="required" />
            <label for="confirmPassword">Confirm Password</label>

            <form:errors path="confirmPassword" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <input type="submit" value="Register">
        </div>
        <div class="signup-link">
            Not a member? <a href="/login">Login now</a>
        </div>
    </form:form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
<script>
    $(document).ready(function() {
        $("#registrationForm").validate({
            rules: {
                fullName: {
                    required: true,
                    minlength: 2
                },
                email: {
                    required: true,
                    email: true
                },
                phone: {
                    required: true,
                    digits: true,
                    minlength: 10,
                    maxlength: 15
                },
                address: {
                    required: true,
                    minlength: 5
                },
                password: {
                    required: true,
                    minlength: 6
                },
                confirmPassword: {
                    required: true,
                    equalTo: "#password"
                }
            },
            messages: {
                fullName: {
                    required: "Please enter your full name",
                    minlength: "Your name must consist of at least 2 characters"
                },
                email: {
                    required: "Please enter your email address",
                    email: "Please enter a valid email address"
                },
                phone: {
                    required: "Please enter your phone number",
                    digits: "Please enter only digits",
                    minlength: "Your phone number must be at least 10 digits long",
                    maxlength: "Your phone number must not be more than 15 digits long"
                },
                address: {
                    required: "Please enter your address",
                    minlength: "Your address must be at least 5 characters long"
                },
                password: {
                    required: "Please provide a password",
                    minlength: "Your password must be at least 6 characters long"
                },
                confirmPassword: {
                    required: "Please confirm your password",
                    equalTo: "Passwords do not match"
                }
            },
            errorElement: "div",
            errorPlacement: function(error, element) {
                error.addClass("error");
                error.insertAfter(element);
            },
            highlight: function(element, errorClass, validClass) {
                $(element).addClass("is-invalid").removeClass("is-valid");
            },
            unhighlight: function(element, errorClass, validClass) {
                $(element).addClass("is-valid").removeClass("is-invalid");
            }
        });
    });
</script>
</body>
</html>
