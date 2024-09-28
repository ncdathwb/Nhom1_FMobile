<%--
  Created by IntelliJ IDEA.
  User: ThinkPad T470
  Date: 9/10/2024
  Time: 1:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- Created By CodingNepal -->
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Reset Password | FMOBILE</title>
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
        #timer {
            font-size: 14px;
            color: gray;
        }
        .field {
            position: relative;
        }

        #otp-input {
            padding-right: 50px; /* Để lại không gian bên phải cho đồng hồ đếm ngược */
        }

        #timer {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            color: gray;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="wrapper">
    <div class="title">
        Verify
    </div>
    <%--@elvariable id="resetpassword" type="com.group1.fmobile.domain.dto.ResetPasswordDTO"--%>
    <form:form action="/reset-password" method="post" modelAttribute="resetpassword">

        <div class="mb-5 field">
            <form:input type="text" required="required" path="otp" id="otp-input"/>
            <label for="otp">Verification code</label>
            <form:errors path="otp" cssClass="error" />

        </div>
        <div class="mb-5 field">
            <form:input type="password" path="newPassword" required="required"/>
            <label for="newPassword">Password</label>
            <form:errors path="newPassword" cssClass="error" />
        </div>
        <div class="mb-5 field">
            <form:input type="password" path="confirmNewPassword" required="required" />
            <label for="confirmNewPassword">Confirm Password</label>
            <form:errors path="confirmNewPassword" cssClass="error" />
        </div>
        <div class="field">
            <input type="submit" value="Submit">
        </div>
        <div class="signup-link">
            back to login <a href="/login">login now</a>
        </div>
    </form:form>
</div>

</body>
</html>
