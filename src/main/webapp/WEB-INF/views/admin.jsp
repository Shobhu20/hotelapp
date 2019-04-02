<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <sec:authorize access="hasRole('ADMIN')">
        <title>Admin Panel</title>
    </sec:authorize>


    <jsp:include page="includes/head.jsp"/>

    <script type="text/javascript" src="<c:url value='/static/js/room-validations.js' />"></script>

    <script>
        window.onload = onStart();

        function onStart() {
            if (window.location.hash) {
                window.location.href = "/admin";
                //load(window.location.hash.substring(2));
            }
        }

    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#success').delay(3000).fadeOut();
        });

        $(document).ready(function () {
            $('#sampleForm').submit(
                function (event) {
                    var firstname = $('#firstname').val();
                    var lastname = $('#lastname').val();
                    var data = 'firstname='
                        + encodeURIComponent(firstname)
                        + '&lastname='
                        + encodeURIComponent(lastname);
                    $.ajax({
                        url: $("#sampleForm").attr("action"),
                        data: data,
                        type: "GET",

                        success: function (response) {
                            alert(response);
                        },
                        error: function (xhr, status, error) {
                            alert(xhr.responseText);
                        }
                    });
                    return false;
                });
        });
    </script>
</head>
<body>
<jsp:include page="includes/staff_header.jsp"/>
<div class="container-fluid" id="main" style="max-height: 100%; overflow-y: hidden; overflow-x: hidden">
    <div class="row" style="overflow-x: hidden; overflow-y: hidden;">

        <div class="col-md-3 col-lg-2 theme-black side-nav" id="admin_sidebar" role="navigation"
             style="min-height: 100%; position: fixed; margin-left: 0;">
            <ul class="nav md-pills pills-primary nav-pills nav-stacked" role="tablist">
                <li class="nav-item card-block">
                    <a class="nav-link white-text active" data-toggle="tab" href="#dashboard" role="tab">Overview</a>
                </li>
                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item card-block">
                        <a class="nav-link white-text" data-toggle="tab" href="#bookings" role="tab"> Bookings</a>
                    </li>
                    <li class="nav-item card-block">
                        <a class="nav-link white-text" data-toggle="tab" href="#admins" role="tab"> Admins</a>
                    </li>
                </sec:authorize>

                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item card-block">
                        <a class="nav-link white-text" data-toggle="tab" href="#customers" role="tab"> Customers</a>
                    </li>
                </sec:authorize>
            </ul>
        </div>

        <div id="right_side_body" class="col-md-10 col-lg-10 main">
            <div class="tab-content vertical">

                <!--Overview-->
                <div class="tab-pane fade in active" id="dashboard" role="tabpanel">

                    <div id="success">
                        <c:if test="${success != null}">
                            <div class="alert alert-success lead">
                                    ${success}
                            </div>
                        </c:if>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="card card-inverse card-danger">
                                <div class="card-block bg-danger">
                                    <h4 class="text-uppercase admin-cards">TOTAL BOOKINGS
                                        <span class="admin-cards-text">${totalbookings}</span>
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="card card-inverse card-warning">
                                <div class="card-block bg-warning">
                                    <h4 class="text-uppercase admin-cards">TOTAL ROOMS
                                        <span class="admin-cards-text">${totalrooms}</span>
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="card card-inverse card-info">
                                <div class="card-block bg-info">
                                    <h4 class="text-uppercase admin-cards">TOTAL CUSTOMERS
                                        <span class="admin-cards-text">${totalcustomers}</span>
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <sec:authorize access="hasRole('ADMIN')">
                            <div class="col-lg-6 col-md-6">
                                <div class="card card-inverse card-success">
                                    <div class="card-block bg-success unique-color">
                                        <h4 class="text-uppercase admin-cards">TOTAL ADMINS
                                            <span class="admin-cards-text">${totaladmins}</span>
                                        </h4>
                                    </div>
                                </div>
                            </div>
                        </sec:authorize>
                    </div>
                    <hr>
                    <div class="row">
                        <sec:authorize access="hasRole('ADMIN')">
                            <div class="col-lg-12 col-md-6" style="text-align: center">
                                <a href="<c:url value="/admin/new/user" />">
                                    <button id="create_user" type="button"
                                            class="btn white-text waves-button waves-light light-blue"
                                            style="font-weight: 300; width: 150px;">CREATE USER
                                    </button>
                                </a>
                                <a style="margin-left: 20px" href="<c:url value="/admin/new/room" />">
                                    <button id="add_room" type="button"
                                            class="btn white-text waves-button waves-light light-blue"
                                            style="font-weight: 300; width: 150px;">ADD ROOM
                                    </button>
                                </a>
                            </div>
                        </sec:authorize>
                    </div>

                </div>
                <!--/.Overview-->

                <!--Available Rooms List-->
                <div class="tab-pane fade" id="rooms" role="tabpanel">
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${fn:length(rooms) > 0}">
                                <table class="table table-striped">
                                    <thead class="thead-inverse">
                                    <tr>
                                        <th>No</th>
                                        <th>Name</th>
                                        <th>Class</th>
                                        <th>Price</th>
                                        <th>More</th>
                                        <th>Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <sec:authorize access="hasRole('ADMIN')">
                                        <c:forEach items="${rooms}" var="room">
                                            <tr>
                                                <td>${room.id}</td>
                                                <td>${room.name}</td>
                                                <td>${room.type.type}</td>
                                                <td>$${room.type.basePrice}</td>
                                                <td>
                                                    <button type="button"
                                                            class="btn grey btn-sm table-actions-buttons"
                                                            data-toggle="modal" data-target="#${room.id}">View
                                                    </button>
                                                </td>
                                                <td class="table-actions">
                                                    <a href="<c:url value='/admin/room/delete-${room.id}' />"
                                                       onclick="return confirm('Are you sure you want to remove this room?')"
                                                       class="btn material-red btn-sm table-actions-buttons">Delete</a>
                                                </td>
                                            </tr>

                                            <div class="modal hide fade" id="${room.id}" tabindex="-1" role="dialog"
                                                 aria-labelledby="company-about-label"
                                                 aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog modal-sm">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal"
                                                                    aria-hidden="true"
                                                                    style="font-size: 12px;">CLOSE
                                                            </button>
                                                            <h4 class="modal-title" id="name"
                                                                style="float: left">${room.name}
                                                            </h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Description: ${room.description}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </sec:authorize>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <h4 class="h4-responsive text-muted" style="margin-top: 30px"> There are currently no
                                    rooms added to system yet.</h4>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <sec:authorize access="hasRole('ADMIN')">
                    <!-- All Bookings List-->
                    <div class="tab-pane fade" id="bookings" role="tabpanel">
                        <div class="table-responsive">
                            <c:choose>
                                <c:when test="${fn:length(bookings) > 0}">
                                    <table class="table table-striped">
                                        <thead class="thead-inverse">
                                        <tr>
                                            <th>No</th>
                                            <th>Room</th>
                                            <th>People</th>
                                            <th>Comment</th>
                                            <th>Arrival Time</th>
                                            <th>Departure Time</th>
                                            <th>Booked By</th>
                                            <th>Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${bookings}" var="booking">
                                            <tr>
                                                <td>${booking.id}</td>
                                                <c:choose>
                                                    <c:when test="${booking.room != null}">
                                                        <td>${booking.room.name}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>${booking.roomBooked}</td>
                                                    </c:otherwise>
                                                </c:choose>

                                                <td>${booking.people}</td>
                                                <td>
                                                    <button type="button"
                                                            class="btn grey btn-sm table-actions-buttons"
                                                            data-toggle="modal" data-target="#${booking.id}">View
                                                    </button>
                                                </td>
                                                <td>${booking.arrivalTime}</td>
                                                <td>${booking.departureTime}</td>
                                                <td>${booking.user.username}</td>
                                                <td>${booking.status}</td>
                                            </tr>
                                            <div class="modal hide fade" id="${booking.id}" tabindex="-1" role="dialog"
                                                 aria-labelledby="company-about-label"
                                                 aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog modal-sm">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal"
                                                                    aria-hidden="true"
                                                                    style="font-size: 12px;">CLOSE
                                                            </button>
                                                            <h4 class="modal-title" id="bookingroom"
                                                                style="float: left">${booking.room.name}
                                                            </h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Description: ${booking.comment}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <h4 class="h4-responsive text-muted" style="margin-top: 30px"> No bookings created
                                        yet.</h4>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!--/.All Bookings List-->

                </sec:authorize>

                <!--Admins List-->
                <div class="tab-pane fade" id="admins" role="tabpanel">
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${fn:length(admins) > 0}">
                                <table class="table table-striped">
                                    <thead class="thead-inverse">
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Email</th>
                                        <sec:authorize access="hasRole('ADMIN')">
                                            <th>Actions</th>
                                        </sec:authorize>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${admins}" var="admins">
                                        <tr>
                                            <td>${admins.id}</td>
                                            <td>${admins.username}</td>
                                            <td>${admins.firstName}</td>
                                            <td>${admins.lastName}</td>
                                            <td>${admins.email}</td>
                                            <sec:authorize access="hasRole('ADMIN')">
                                                <td class="table-actions">
                                                    <a href="<c:url value='admin/user/edit-${admins.username}' />"
                                                       class="btn light-blue btn-sm table-actions-buttons">Edit</a>

                                                    <c:if test="${username != admins.username}">
                                                        <a href="<c:url value='admin/user/delete-${admins.username}' />"
                                                           onclick="return confirm('Are you sure you want to delete this admin?')"
                                                           class="btn material-red btn-sm table-actions-buttons">Delete</a>
                                                    </c:if>
                                                </td>
                                            </sec:authorize>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <h4 class="h4-responsive text-muted" style="margin-top: 30px"> No admins assigned
                                    yet.</h4>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!--/.Admins List-->



                <!--Customers List-->
                <div class="tab-pane fade" id="customers" role="tabpanel">
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${fn:length(customers) > 0}">
                                <table class="table table-striped">
                                    <thead class="thead-inverse">
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>Email</th>
                                        <sec:authorize access="hasRole('ADMIN')">
                                            <th>Actions</th>
                                        </sec:authorize>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${customers}" var="customers">
                                        <tr>
                                            <td>${customers.id}</td>
                                            <td>${customers.username}</td>
                                            <td>${customers.firstName}</td>
                                            <td>${customers.lastName}</td>
                                            <td>${customers.email}</td>
                                            <sec:authorize access="hasRole('ADMIN')">
                                                <td class="table-actions">
                                                    <a href="<c:url value='admin/user/edit-${customers.username}' />"
                                                       class="btn light-blue btn-sm table-actions-buttons">Edit</a>

                                                    <a href="<c:url value='admin/user/delete-${customers.username}' />"
                                                       onclick="return confirm('Are you sure you want to delete this customer?')"
                                                       class="btn material-red btn-sm table-actions-buttons">Delete</a>
                                                </td>
                                            </sec:authorize>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                            </c:when>
                            <c:otherwise>
                                <h4 class="h4-responsive text-muted" style="margin-top: 30px"> No customers registered
                                    yet.</h4>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!--/.Customers List-->

            </div>
        </div>
    </div>
</div>
</body>
</html>