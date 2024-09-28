
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="contextPath" content="${pageContext.request.contextPath}">
    <!-- Add these meta tags in your JSP file -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>UserPage</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="/css/style.css">
    <style>
        html {
            font-size: 62.5%;
        }
        body {
            font-family: Monospaced;
        }
        a {
            text-decoration: none;
        }
        .avatar-wrapper {
            position: relative;
            width: 150px;
            height: 150px;
            overflow: hidden;
            border-radius: 50%;
            cursor: pointer;
        }
        .avatar-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .avatar-wrapper input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .form-group {
            font-size: 20px;
        }

        .btn {
            font-size: 15px;
        }

        input {
            height: 30px;
        }

        table td, table th {
            vertical-align: middle; /* Đảm bảo tất cả nội dung căn giữa theo chiều dọc */
        }

        input[type="checkbox"] {
            position: relative;
            top: 5px;
            transform: translateY(-1px); /* Điều chỉnh nhỏ để căn chỉnh tốt hơn */
            margin: 0; /* Loại bỏ khoảng trống không cần thiết */
        }

        .logout_btn:hover {
            opacity: 0.9;
        }

        /* Increase form control size */
        .form-control {
            padding: 0.75rem;
            font-size: 1.1rem;
        }


        .login_username {
            color: #0d6efd;
            font-size: 15px;
        }
        /* ---------------------------Main-------------------------- */
        .view-account{
            margin-top:50px;
        }
        .view-account .pro-label {
            border: 1px solid #0066cc;
            background: #0066cc;
            color: #fff;
            font-size: 13px;
            padding: 4px 5px;
            position: relative;
            top: -5px;
            margin-left: 10px;
            display: inline-block
        }

        .view-account .side-bar {
            padding-bottom: 30px
        }

        .view-account .side-bar .user-info {
            text-align: center;
            margin-bottom: 15px;
            padding: 30px;
            color: #616670;
            border-bottom: 1px solid #f3f3f3
        }

        .view-account .side-bar .user-info .img-profile {
            width: 120px;
            height: 120px;
            margin-bottom: 15px;
        }

        .view-account .side-bar .user-info .meta li {
            margin-bottom: 10px
        }

        .view-account .side-bar .user-info .meta li span {
            display: inline-block;
            width: 100px;
            margin-right: 5px;
            text-align: right
        }

        .view-account .side-bar .user-info .meta li a {
            color: #616670
        }

        .view-account .side-bar .user-info .meta li.activity {
            color: #a2a6af
        }

        .view-account .side-bar .side-menu {
            text-align: center
        }

        .view-account .side-bar .side-menu .nav {
            display: inline-block;
            margin: 0 auto
        }

        .view-account .side-bar .side-menu .nav>li {
            font-size: 14px;
            margin-bottom: 0;
            border-bottom: none;
            display: inline-block;
            float: left;
            margin-right: 15px;
            margin-bottom: 15px
        }

        .view-account .side-bar .side-menu .nav>li:last-child {
            margin-right: 0
        }

        .view-account .side-bar .side-menu .nav>li>a {
            display: inline-block;
            color: #9499a3;
            padding: 5px;
            border-bottom: 2px solid transparent
        }

        .view-account .side-bar .side-menu .nav>li>a:hover {
            color: #616670;
            background: none
        }

        .view-account .side-bar .side-menu .nav>li.active a {
            color: #40babd;
            border-bottom: 2px solid #40babd;
            background: none;
            border-right: none
        }

        .theme-2 .view-account .side-bar .side-menu .nav>li.active a {
            color: #6dbd63;
            border-bottom-color: #6dbd63
        }

        .theme-3 .view-account .side-bar .side-menu .nav>li.active a {
            color: #497cb1;
            border-bottom-color: #497cb1
        }

        .theme-4 .view-account .side-bar .side-menu .nav>li.active a {
            color: #ec6952;
            border-bottom-color: #ec6952
        }

        .view-account .side-bar .side-menu .nav>li .icon {
            display: block;
            font-size: 24px;
            margin-bottom: 5px
        }

        .view-account .content-panel {
            padding: 30px
        }

        .view-account .content-panel .title {
            margin-bottom: 15px;
            margin-top: 0;
            font-size: 18px
        }

        .view-account .content-panel .fieldset-title {
            padding-bottom: 15px;
            border-bottom: 1px solid #eaeaf1;
            margin-bottom: 30px;
            color: #616670;
            font-size: 20px
        }

        .view-account .content-panel .avatar .figure img {
            float: right;
            width: 64px
        }

        .view-account .content-panel .content-header-wrapper {
            position: relative;
            margin-bottom: 30px
        }

        .view-account .content-panel .content-header-wrapper .actions {
            position: absolute;
            right: 0;
            top: 0
        }

        .view-account .content-panel .content-utilities {
            position: relative;
            margin-bottom: 30px
        }

        .view-account .content-panel .content-utilities .btn-group {
            margin-right: 5px;
            margin-bottom: 15px
        }

        .view-account .content-panel .content-utilities .fa {
            font-size: 16px;
            margin-right: 0
        }

        .view-account .content-panel .content-utilities .page-nav {
            position: absolute;
            right: 0;
            top: 0
        }

        .view-account .content-panel .content-utilities .page-nav .btn-group {
            margin-bottom: 0
        }

        .view-account .content-panel .content-utilities .page-nav .indicator {
            color: #a2a6af;
            margin-right: 5px;
            display: inline-block
        }

        .view-account .content-panel .mails-wrapper .mail-item {
            position: relative;
            padding: 10px;
            border-bottom: 1px solid #f3f3f3;
            color: #616670;
            overflow: hidden
        }

        .view-account .content-panel .mails-wrapper .mail-item>div {
            float: left
        }

        .view-account .content-panel .mails-wrapper .mail-item .icheck {
            background-color: #fff
        }

        .view-account .content-panel .mails-wrapper .mail-item:hover {
            background: #f9f9fb
        }

        .view-account .content-panel .mails-wrapper .mail-item:nth-child(even) {
            background: #fcfcfd
        }

        .view-account .content-panel .mails-wrapper .mail-item:nth-child(even):hover {
            background: #f9f9fb
        }

        .view-account .content-panel .mails-wrapper .mail-item a {
            color: #616670
        }

        .view-account .content-panel .mails-wrapper .mail-item a:hover {
            color: #494d55;
            text-decoration: none
        }

        .view-account .content-panel .mails-wrapper .mail-item .checkbox-container,
        .view-account .content-panel .mails-wrapper .mail-item .star-container {
            display: inline-block;
            margin-right: 5px
        }

        .view-account .content-panel .mails-wrapper .mail-item .star-container .fa {
            color: #a2a6af;
            font-size: 16px;
            vertical-align: middle
        }

        .view-account .content-panel .mails-wrapper .mail-item .star-container .fa.fa-star {
            color: #f2b542
        }

        .view-account .content-panel .mails-wrapper .mail-item .star-container .fa:hover {
            color: #868c97
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-to {
            display: inline-block;
            margin-right: 5px;
            min-width: 120px
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject {
            display: inline-block;
            margin-right: 5px
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label {
            margin-right: 5px
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label:last-child {
            margin-right: 10px
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label a,
        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label a:hover {
            color: #fff
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-1 {
            background: #f77b6b
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-2 {
            background: #58bbee
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-3 {
            background: #f8a13f
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-4 {
            background: #ea5395
        }

        .view-account .content-panel .mails-wrapper .mail-item .mail-subject .label-color-5 {
            background: #8a40a7
        }

        .view-account .content-panel .mails-wrapper .mail-item .time-container {
            display: inline-block;
            position: absolute;
            right: 10px;
            top: 10px;
            color: #a2a6af;
            text-align: left
        }

        .view-account .content-panel .mails-wrapper .mail-item .time-container .attachment-container {
            display: inline-block;
            color: #a2a6af;
            margin-right: 5px
        }

        .view-account .content-panel .mails-wrapper .mail-item .time-container .time {
            display: inline-block;
            text-align: right
        }

        .view-account .content-panel .mails-wrapper .mail-item .time-container .time.today {
            font-weight: 700;
            color: #494d55
        }

        .drive-wrapper {
            padding: 15px;
            background: #f5f5f5;
            overflow: hidden
        }

        .drive-wrapper .drive-item {
            width: 130px;
            margin-right: 15px;
            display: inline-block;
            float: left
        }

        .drive-wrapper .drive-item:hover {
            box-shadow: 0 1px 5px rgba(0, 0, 0, .1);
            z-index: 1
        }

        .drive-wrapper .drive-item-inner {
            padding: 15px
        }

        .drive-wrapper .drive-item-title {
            margin-bottom: 15px;
            max-width: 100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis
        }

        .drive-wrapper .drive-item-title a {
            color: #494d55
        }

        .drive-wrapper .drive-item-title a:hover {
            color: #40babd
        }

        .theme-2 .drive-wrapper .drive-item-title a:hover {
            color: #6dbd63
        }

        .theme-3 .drive-wrapper .drive-item-title a:hover {
            color: #497cb1
        }

        .theme-4 .drive-wrapper .drive-item-title a:hover {
            color: #ec6952
        }

        .drive-wrapper .drive-item-thumb {
            width: 100px;
            height: 80px;
            margin: 0 auto;
            color: #616670
        }

        .drive-wrapper .drive-item-thumb a {
            -webkit-opacity: .8;
            -moz-opacity: .8;
            opacity: .8
        }

        .drive-wrapper .drive-item-thumb a:hover {
            -webkit-opacity: 1;
            -moz-opacity: 1;
            opacity: 1
        }

        .drive-wrapper .drive-item-thumb .fa {
            display: inline-block;
            font-size: 36px;
            margin: 0 auto;
            margin-top: 20px
        }

        .drive-wrapper .drive-item-footer .utilities {
            margin-bottom: 0
        }

        .drive-wrapper .drive-item-footer .utilities li:last-child {
            padding-right: 0
        }

        .drive-list-view .name {
            width: 60%
        }

        .drive-list-view .name.truncate {
            max-width: 100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis
        }

        .drive-list-view .type {
            width: 15px
        }

        .drive-list-view .date,
        .drive-list-view .size {
            max-width: 60px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis
        }

        .drive-list-view a {
            color: #494d55
        }

        .drive-list-view a:hover {
            color: #40babd
        }

        .theme-2 .drive-list-view a:hover {
            color: #6dbd63
        }

        .theme-3 .drive-list-view a:hover {
            color: #497cb1
        }

        .theme-4 .drive-list-view a:hover {
            color: #ec6952
        }

        .drive-list-view td.date,
        .drive-list-view td.size {
            color: #a2a6af
        }

        @media (max-width:767px) {
            .view-account .content-panel .title {
                text-align: center
            }
            .view-account .side-bar .user-info {
                padding: 0
            }
            .view-account .side-bar .user-info .img-profile {
                width: 60px;
                height: 60px
            }
            .view-account .side-bar .user-info .meta li {
                margin-bottom: 5px
            }
            .view-account .content-panel .content-header-wrapper .actions {
                position: static;
                margin-bottom: 30px
            }
            .view-account .content-panel {
                padding: 0
            }
            .view-account .content-panel .content-utilities .page-nav {
                position: static;
                margin-bottom: 15px
            }
            .drive-wrapper .drive-item {
                width: 100px;
                margin-right: 5px;
                float: none
            }
            .drive-wrapper .drive-item-thumb {
                width: auto;
                height: 54px
            }
            .drive-wrapper .drive-item-thumb .fa {
                font-size: 24px;
                padding-top: 0
            }
            .view-account .content-panel .avatar .figure img {
                float: none;
                margin-bottom: 15px
            }
            .view-account .file-uploader {
                margin-bottom: 15px
            }
            .view-account .mail-subject {
                max-width: 100px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis
            }
            .view-account .content-panel .mails-wrapper .mail-item .time-container {
                position: static
            }
            .view-account .content-panel .mails-wrapper .mail-item .time-container .time {
                width: auto;
                text-align: left
            }
        }

        @media (min-width:768px) {
            .view-account .side-bar .user-info {
                padding: 0;
                padding-bottom: 15px
            }
            .view-account .mail-subject .subject {
                max-width: 200px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis
            }
        }

        @media (min-width:992px) {
            .view-account .content-panel {
                min-height: 800px;
                border-left: 1px solid #f3f3f7;
                margin-left: 200px
            }
            .view-account .mail-subject .subject {
                max-width: 280px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis
            }
            .view-account .side-bar {
                position: absolute;
                width: 200px;
                min-height: 600px
            }
            .view-account .side-bar .user-info {
                margin-bottom: 0;
                border-bottom: none;
                padding: 30px
            }
            .view-account .side-bar .user-info .img-profile {
                width: 120px;
                height: 120px
            }
            .view-account .side-bar .side-menu {
                text-align: left
            }
            .view-account .side-bar .side-menu .nav {
                display: block
            }
            .view-account .side-bar .side-menu .nav>li {
                display: block;
                float: none;
                font-size: 14px;
                border-bottom: 1px solid #f3f3f7;
                margin-right: 0;
                margin-bottom: 0
            }
            .view-account .side-bar .side-menu .nav>li>a {
                display: block;
                color: #9499a3;
                padding: 10px 15px;
                padding-left: 30px
            }
            .view-account .side-bar .side-menu .nav>li>a:hover {
                background: #f9f9fb
            }
            .view-account .side-bar .side-menu .nav>li.active a {
                background: #f9f9fb;
                border-right: 4px solid #40babd;
                border-bottom: none
            }
            .theme-2 .view-account .side-bar .side-menu .nav>li.active a {
                border-right-color: #6dbd63
            }
            .theme-3 .view-account .side-bar .side-menu .nav>li.active a {
                border-right-color: #497cb1
            }
            .theme-4 .view-account .side-bar .side-menu .nav>li.active a {
                border-right-color: #ec6952
            }
            .view-account .side-bar .side-menu .nav>li .icon {
                font-size: 24px;
                vertical-align: middle;
                text-align: center;
                width: 40px;
                display: inline-block
            }
        }

        .nav a {
            font-size: 1.8rem;
            color: #007bff;
        }

        .footer li {
            font-size: 1.5rem;
        }

        .inpbox {
            height: 50px;
            width: 500px;
            border-radius: 5px;
            padding-left: 5px;
        }

    </style>
</head>

<body class="">
<div id="notification" style="
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #f8d7da;
    color: #721c24;
    padding: 15px 20px;
    border-radius: 5px;
    z-index: 1000;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    font-size: 16px;
    text-align: center;
    max-width: 80%;
">
</div>
<!-- Nav -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container-fluid">
        <a href="#">
            <img class="logo-nav" src="/images/product/FMobileLogo.png" alt="" />
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse ml-5" id="navbarNav" style="width: 750px">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="m4 12 8-8 8 8M6 10.5V19a1 1 0 0 0 1 1h3v-3a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3h3a1 1 0 0 0 1-1v-8.5" />
                    </svg>
                    <a class="nav-link menu" aria-current="page" href="/client/homepage">Home</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                         viewBox="0 0 24 24">
                        <path fill-rule="evenodd"
                              d="M5 4a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V4Zm12 12V5H7v11h10Zm-5 1a1 1 0 1 0 0 2h.01a1 1 0 1 0 0-2H12Z"
                              clip-rule="evenodd" />
                    </svg>
                    <a class="nav-link menu" href="#">Mobile</a>
                </li>
                <li class="nav-item">
                    <i class="fas fa-laptop"></i>
                    <a class="nav-link menu" href="#">Laptop</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 18h2M5.875 3h12.25c.483 0 .875.448.875 1v16c0 .552-.392 1-.875 1H5.875C5.392 21 5 20.552 5 20V4c0-.552.392-1 .875-1Z" />
                    </svg>
                    <a class="nav-link menu" href="#">Tablet</a>
                </li>
                <li class="nav-item">
                    <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                         xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                         viewBox="0 0 24 24">
                        <path fill-rule="evenodd"
                              d="M12 5a7 7 0 0 0-7 7v1.17c.313-.11.65-.17 1-.17h2a1 1 0 0 1 1 1v6a1 1 0 0 1-1 1H6a3 3 0 0 1-3-3v-6a9 9 0 0 1 18 0v6a3 3 0 0 1-3 3h-2a1 1 0 0 1-1-1v-6a1 1 0 0 1 1-1h2c.35 0 .687.06 1 .17V12a7 7 0 0 0-7-7Z"
                              clip-rule="evenodd" />
                    </svg>
                    <a class="nav-link menu" href="#">Accessories</a>
                </li>
                <form class="d-flex ml-5 mb-2">
                    <div class="search-icon" style="width: 330px">
                        <input class="form-control search_nav" type="search" placeholder="Search"
                               aria-label="Search"
                               style="font-size: 1.5rem;
                                        height: 40px;
                                        padding-top: 8px;
                                        border-radius: 5px;" />
                        <svg style="right: 105px;
                                    top: 60%;" class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none"
                             viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-width="2"
                                  d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z" />
                        </svg>
                    </div>
                </form>
            </ul>
        </div>
        <div class="icon-cart" style="margin-left: 30px">
            <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M6 15a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0h8m-8 0-1-4m9 4a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-9-4h10l2-7H3m2 7L3 4m0 0-.792-3H1" />
            </svg>
            <span>0</span>
        </div>
        <div class="navbar-nav">
            <security:authorize access="isAuthenticated()">
                <a class="me-2">
                    <img class="logo-nav rounded-circle" style="width: 40px; height: 40px; object-fit: cover; background: #007bff;" src="/client/img/avatar.jpg" alt="user" />
                </a>
                <div class="mt-3" style="font-size: 1.5rem">
                    <security:authentication var="userEmail" property="principal.username" />
                    <c:set var="username" value="${fn:substringBefore(userEmail, '@')}" />
                        ${fullName}
                </div>
                <form id="logoutForm" method="post" action="/logout" class="mt-2">
                    <security:csrfInput />
                    <button type="submit" style="width: 70px; height: 30px" class="btn btn-outline-primary" onclick="logout(event)">Logout</button>
                </form>
            </security:authorize>
        </div>
        <div class="form-check form-switch dark-mode-toggle mx-3">
            <input class="form-check-input" type="checkbox" id="darkModeToggle" />
            <label class="form-check-label" style="width: 60px; font-size: 1.2rem" for="darkModeToggle">Dark Mode</label>
        </div>
    </div>
</nav>
<%--Main--%>
<div class="container">
    <div class="view-account" style="margin-top: 60px">
        <section class="module">
            <div class="module-inner">
                <div class="side-bar">
                    <div class="user-info">
                        <div class="form-group d-flex flex-column align-items-center">
                            <div class="avatar-wrapper mb-3">
                                <img id="avatar" class="img-fluid" src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="Avatar">
                                <input type="file" id="avatarInput" accept="image/*">
                            </div>
                            <button id="updateImage" class="btn btn-primary mt-auto">Update Image</button>
                        </div>
                    </div>
                    <nav class="side-menu">
                        <ul class="nav">
                            <li><a href="#" id="profileLink"><span class="fa fa-user mx-2"></span>Profile</a></li>
                            <li><a href="/client/homepage/purchase-history"><span class="fa fa-cog mx-2"></span>Purchase History</a></li>
                            <li><a href="/client/homepage/"><span class="fa-solid fa-house mx-2"></span>Home</a></li>
                        </ul>
                    </nav>
                </div>
                <div id="contentDisplay"></div>
            </div>
        </section>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function logout(event) {
        event.preventDefault();
        fetch('/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams(new FormData(document.getElementById('logoutForm'))),
        }).then(() => {
            window.location.href = '/client/homepage';  // Redirect to homepage after logout
        }).catch(error => {
            console.error('Logout error:', error);
        });
    }
</script>
<script>
    //--------------------------- Display noi dung tuong ung----------------------
    document.addEventListener('DOMContentLoaded', function() {
        const profileLink = document.getElementById('profileLink');
        const contentDisplay = document.getElementById('contentDisplay');

        // HTML content for Profile
        const profileContent = `
    <div class="content-panel mt-3" style="min-height:750px">
        <div class="main_content">
            <div class="main_content-right">
                 <h2 class="title">Profile<span class="pro-label label label-warning">PRO</span></h2>
                <form class="form-horizontal">
                 <fieldset class="fieldset">
                    <h1 style="color: #007bff;">PERSONAL INFO</h1>
                    </fieldset>
                        <fieldset class="fieldset mb-5">

                        <div class="form-group">
                            <label class="col-md-2 col-sm-3 col-xs-12 label_form">Password:</label>
                            <div class="col-md-10 col-sm-9 col-xs-12">
                                <p style="font-size: 2rem"><a href="/reset-password" class="change">Reset password</a></p>
                            </div>
                        </div>

                        <div class="form-group mt-3">
                            <label class="col-md-2 col-sm-3 col-xs-12 label_form">Full Name:</label>
                            <div class="col-md-10 col-sm-9 col-xs-12">
                                <label class="inputName">
                                    <input class="inpbox" aria-required="true" type="text" data-val="true" data-val-length-max="30" id="Input_FistName" maxlength="30" name="Input.FistName" value="${user.fullName}" readonly/>
                                </label>
                            </div>
                        </div>

                        <div class="form-group mt-3">
                        <label class="col-md-2 col-sm-3 col-xs-12 label_form">Phone:</label>
                        <div class="col-md-10 col-sm-9 col-xs-12">
                            <label class="inputName">
                                 <input class="inpbox" aria-required="true" type="text" data-val="true" data-val-length-max="30" id="Input_FistName" maxlength="30" name="Input.FistName" value="${user.phone}" readonly/>
                            </label>
                        </div>
                    </div>

                    <div class="form-group mt-3">
                        <label class="label_form" ss="col-md-2 col-sm-3 col-xs-12">Address:</label>
                        <div class="col-md-10 col-sm-9 col-xs-12">
                            <label class="inputName">
                                <input class="inpbox" aria-required="true" type="text" data-val="true" data-val-length-max="30" id="Input_FistName" maxlength="30" name="Input.FistName" value="${user.address}" readonly/>
                            </label>
                        </div>
                    </div>

                    <div class="form-group mt-3">
                        <label class="col-md-2 col-sm-3 col-xs-12 label_form">Creation Date:</label>
                        <div class="col-md-10 col-sm-9 col-xs-12">
                            <label class="inputName">
                                <input class="inpbox" aria-required="true" type="text" data-val="true" data-val-length-max="30" id="Input_FistName" maxlength="30" name="Input.FistName" value="${user.creationDate}" readonly/>
                            </label>
                        </div>
                    </div>
                </fieldset>
                    <div class="form-group mt-5">
                        <div class="col-md-10 col-sm-9 col-xs-12 col-md-push-2 col-sm-push-3 col-xs-push-0 mt-3">
                            <a href="/client/homepage/profile" type="button" class="btn btn-primary btn-lg">
                                Update Profile
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
            `;
        // Function to display profile content
        function displayProfile() {
            contentDisplay.innerHTML = profileContent;
        }
        // Display profile content by default when the page loads
        displayProfile();

        // Event listener for Profile link
        profileLink.addEventListener('click', function(e) {
            e.preventDefault();
            displayProfile();
        });
    });

    document.getElementById('saveChangesBtn').addEventListener('click', function() {
        const updateData = {
            email: user.email, // Assuming you have the user's email stored
            fullName: document.getElementById('fullName').value,
            phone: document.getElementById('phone').value,
            address: document.getElementById('address').value
        };

        fetch('/client/homepage/userpage', {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(updateData)
        })
            .then(response => response.json())
            .then(data => {
                // Update the UI with the new data
                user = data;
                updateProfileUI();
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    });

    function updateProfileUI() {
        // Update the UI elements with the new user data
        document.querySelector('input[name="Input.FistName"][value]').value = user.fullName;
        document.querySelector('input[value="' + user.phone + '"]').value = user.phone;
        document.querySelector('input[value="' + user.address + '"]').value = user.address;
    }
</script>
<script>
    //---------------------- Upload anh--------------------
    document.addEventListener('DOMContentLoaded', function() {
        const avatarInput = document.getElementById('avatarInput');
        const avatar = document.getElementById('avatar');
        const updateButton = document.getElementById('updateImage');

        // Load saved image from local storage on page load
        const savedImage = localStorage.getItem('userAvatar');
        if (savedImage) {
            avatar.src = savedImage;
        }

        // Function to handle file selection
        avatarInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    avatar.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
        // Function to trigger file input when clicking on the image
        avatar.addEventListener('click', function() {
            avatarInput.click();
        });
        // Function to handle image update and save to local storage
        updateButton.addEventListener('click', function() {
            if (avatar.src) {
                try {
                    localStorage.setItem('userAvatar', avatar.src);
                    console.log('Image saved to local storage successfully');
                    alert('Image updated and saved locally!');
                } catch (e) {
                    console.error('Error saving to local storage:', e);
                    alert('Failed to save image locally. The image might be too large.');
                }
            } else {
                alert('Please select an image first.');
            }
        });
    });
</script>
<script>
    const darkModeToggle = document.getElementById("darkModeToggle");
    darkModeToggle.addEventListener("change", function () {
        document.body.classList.toggle("dark-mode", darkModeToggle.checked);
    });
</script>
</body>
</html>


