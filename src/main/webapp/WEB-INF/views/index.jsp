<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HOTEL APP</title>

    <jsp:include page="includes/head.jsp"/>

    <style>
        img {
            width: auto;
            height: auto;
            max-width: 100%;
        }
    </style>
</head>
<body class="background">
<jsp:include page="includes/header.jsp"/>

<div id="display_carousel" class="carousel slide carousel-fade display_carousel" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#display_carousel" data-slide-to="0" class=""></li>
        <li data-target="#display_carousel" data-slide-to="1" class=""></li>
        <li data-target="#display_carousel" data-slide-to="2" class="active"></li>
    </ol>

    <div class="carousel-inner" role="listbox">
        <div class="carousel-item">
            <div id="display_image1" class="flex-center animated">
                <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/display1.jpg">
            </div>
        </div>

        <div class="carousel-item">
            <div id="display_image2" class="flex-center animated">
                <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/display2.jpg">
            </div>
        </div>

        <div class="carousel-item active">
            <div id="display_image3" class="flex-center animated">
                <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/display3.jpg">
            </div>
        </div>
    </div>

    <a class="left carousel-control" href="#display_carousel" role="button" data-slide="prev">
        <span class="icon-prev" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#display_carousel" role="button" data-slide="next">
        <span class="icon-next" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<section>
    <div class="center-div-horizontal" style="margin-bottom: 30px; margin-top: 30px">
        <h3 style="font-weight: bold; font-family: Roboto">WELCOME TO THE EMERGING HOTEL</h3>



    </div>
    <hr class="container">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>


    <jsp:include page="services.jsp"/>

</section>
</body>
</html>
