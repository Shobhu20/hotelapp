<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Edit Room</title>

    <jsp:include page="includes/head.jsp"/>

    <script type="text/javascript" src="<c:url value='/static/js/room-validations.js' />"></script>
</head>

<body class="background">

<jsp:include page="includes/staff_header.jsp"/>

<section id="add_room" style="margin-top: 5%">

    <form:form action="/admin/room/edit-${room.id}" method="post" modelAttribute="room" enctype="multipart/form-data">
        <form:input type="hidden" path="id" id="id"/>
        <div>
            <h1 class="heading h1-responsive blue-grey center-div white-text card-header">EDIT ROOM</h1>

            <div class="form-group card card-block">

                <div>
                    <label for="name" data-icon="u">Room name</label>
                    <form:input type="text" onchange="verifyRoomName()" path="name" id="name" placeholder="Room 412"
                                required="required"/>
                </div>
                <div class="has-error">
                    <form:errors path="name" class="help-inline material-red-text "/>
                </div>
                </br><%--
                <div>
                    <label for="capacity" data-icon="e">Room Capacity</label>
                    <form:input type="number" onchange="verifyCapacity()" path="capacity" id="capacity"
                                required="required"/>
                </div>
                <div class="has-error">
                    <form:errors path="capacity" class="help-inline material-red-text "/>
                </div>--%>
                </br>
                <div>
                    <label for="description" data-icon="e">Room Description</label>
                    <form:textarea path="description" class="md-textarea" id="description"
                                   placeholder="Specify room features here. Feature 1, Feature 2 ..."/>
                </div>
                <div class="has-error">
                    <form:errors path="description" class="help-inline material-red-text "/>
                </div>
                </br>
                </br>
                <label for="type">Select Room Type</label>

                <div>
                    <form:select path="type" items="${types}" itemValue="id" itemLabel="type" multiple="true"
                                 required="required"
                                 cssClass="input-block-level rgba-white-slight waves-input-wrapper"
                                 cssStyle="padding-top: 10px">
                    </form:select>
                    <div class="has-error">
                        <form:errors path="type" class="help-inline material-red-text "/>
                    </div>
                </div>
                </br>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                </br>
                <div style="text-align: center">
                    <input class="btn btn-blue-grey waves-button waves-light" style="width: 240px; height: 40px"
                           type="submit" value="Update Room"/>
                </div>
                </br>
                <div class="change_link" style="text-align: center">
                    <a href="/admin" class="to_register">GO BACK TO ADMIN PANEL</a>
                </div>
            </div>
        </div>
    </form:form>
</section>
</body>
</html>