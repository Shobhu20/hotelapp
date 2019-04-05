<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>WareHOuse</title>

    <link href="<c:url value='/static/images/favicon.png' />" rel="icon" type="image/x-icon">

    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/bootstrap.min.css' />">
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/bootstrap-responsive.min.css' />">
    <link type="text/css" rel="stylesheet" href="<c:url value='/static/css/mdb.css' />">

    <script type="text/javascript" src="<c:url value='/static/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/bootstrap.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/mdb.js' />"></script>
</head>
<body class="background" style="padding: 20px;">
<jsp:include page="includes/warehouse_header.jsp"/>
<div id="container">
    <section class="half">
        <!-- Trigger the modal with a button -->
        <table class="table table-bordered">
            <thead>
            <th> ${colHeader1}</th>
            </thead>
            <tbody>
            <%--items="${result}" var="entry">--%>

                <td>${result}</td>

            </tbody>
        </table>
    </section>

    <section id="do_migration" style="margin-top: 5%">
        <form:form cssStyle="float: left" action="/warehouse" method="get">
            <div style="float: left; margin-right: 80px;">
                <input class="btn btn-blue-grey waves-button waves-light" style="width: 240px; height: 40px"
                       type="submit" value="BACK"/>
            </div>
        </form:form>
    </section>

</div>





</body>
</html>
