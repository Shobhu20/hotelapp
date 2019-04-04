<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>WareHOuse</title>
    <jsp:include page="includes/head.jsp"/>

</head>
<br class="background">

<section id="do_migration" style="margin-top: 5%">
<form:form action="/do-migration-migrate" method="post">
    <div style="text-align: center">
        <input class="btn btn-blue-grey waves-button waves-light" style="width: 240px; height: 40px"
               type="submit" value="MOVE TO WAREHOUSE"/>
    </div>
</form:form>
    <div>
        <p> Number of rows updated : ${numOfRowsMoved}</p>
    </div>
</section>


</body>
</html>
