<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rooms</title>

    <jsp:include page="includes/head.jsp"/>
</head>
<body>
<jsp:include page="includes/header.jsp"/>


<hr class="container">
<div id="room_types" class="container">
    <h1 class="h1-responsive" style="margin-bottom: 20px">Room Types</h1>
    <hr>
    <div class="col-md-4">
        <div class="card">
            <div class="view overlay hm-white-slight">
                <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/room1.jpg" class="img-fluid" alt="">
            </div>

            <div class="card-block">
                <h4 class="card-title">Family Rooms</h4>

                <p class="card-text">Room perfect for family vacations which includes entertainment facilities
                    like plasma TV, C.D, Stereo and DVD. These rooms provides all necessities for family.</p>

                <div class="read-more">
                    <p id="display_room1_price"
                       style="font-size: 24px; font-weight: bold; color:#000000" >BASE PRICE    $${familybase} </p>
                </div>
            </div>
        </div>
    </div>


        <div class="col-md-4">
            <div class="card">
                <div class="view overlay hm-white-slight">
                    <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/room2.jpg" class="img-fluid" alt="">
                </div>

                <div class="card-block">
                    <h4 class="card-title">Deluxe Rooms</h4>

                    <p class="card-text">Hotel provides the entire world class premium services like plasma TV, C.D,
                        Stereo & DVD,work desks, phone and much more.</p>

                    <div class="read-more">
                        <p id="display_room2_price"
                           style="font-size: 24px; font-weight: bold; color:#000000" >BASE PRICE    $${deluxebase} </p>
                    </div>
                </div>
            </div>
        </div>

    <div class="col-md-4">
        <div class="card">
            <div class="view overlay hm-white-slight">
                <img src="https://res.cloudinary.com/hte2zx5qx/image/upload/room3.jpg" class="img-fluid" alt="">
            </div>

            <div class="card-block">
                <h4 class="card-title">Executive Rooms</h4>

                <p class="card-text"> This include a range of luxurious rooms suitable for
                    its discerning visitors. The different kinds of rooms and suits include the Business suits
                    and Crown Suits.</p>

                <div class="read-more">
                    <p id="display_room3_price"
                       style="font-size: 24px; font-weight: bold; color:#000000" >BASE PRICE    $${executivebase} </p>
                </div>
            </div>
        </div>
    </div>

    </div>

</div>


</div>


</body>
</html>