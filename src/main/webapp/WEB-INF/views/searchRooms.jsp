<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Booking</title>

    <jsp:include page="includes/head.jsp"/>
    <script type="text/javascript" src="<c:url value='/static/js/date-validator.js' />"></script>

    <script>
        function verifyPeople() {
            var check = document.getElementById('people').value;
            if (Number(check) < 0) {
                document.getElementById("people").style.borderColor = '#FF0013';
                document.getElementById("people").value = null;
            } else if (Number(check) > 6) {
                document.getElementById("people").value = 6;
            } else {
                document.getElementById("people").style.borderColor = '#A7FF00';
            }
        }
    </script>
</head>
<body class="background">
<jsp:include page="includes/header.jsp"/>
<form:form action="/search-room" method="POST"
           class="form-horizontal">
<div style="margin-top: 30%">
    <h1 class="heading h1-responsive center-div light-blue white-text card-header">SEARCH ROOMS</h1>

    <div class="form-group card card-block">
        <p>
            <label for="fromdate" data-icon="u"> fromDate </label>
            <input id="fromdate"  name="fromdate" required="required" type="date"
                   placeholder="Enter from date"/>
        </p>
        <p>
            <label for="todate" data-icon="u"> fromDate </label>
            <input id="todate"  name="todate" required="required" type="date"
                   placeholder="Enter to date"/>
        </p>
        <input class="btn btn-primary waves-button waves-light light-blue"
               style="width: 240px; height: 40px" type="submit"  value="Show Rooms"/>
        <%--onclick="return compareDate()"--%>
    </div>
</div>
</form:form>
</body>
</html>