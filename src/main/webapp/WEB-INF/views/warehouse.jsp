<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>WareHouse</title>

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
                    <th> Query</th>
                <th>Action</th>
                </thead>
                <tbody>
                <tr>
                    <td style="font-size: 20px; font-family:'Verdana' ">
                        Get the total amount earned from bookings across each location
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary waves-button waves-light light-blue" data-toggle="modal" data-target="#myModal">Search</button>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 20px; font-family:'Verdana' ">
                        Get the total amount earned by all locations
                    </td>
                    <td>
                        <button type="submit" class="btn btn-primary waves-button waves-light light-blue" data-toggle="modal" data-target="#myModal2" >Search</button>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 20px; font-family:'Verdana' ">
                        Get the sum of amount earned by customers who are NOT from the country of hotel
                    </td>
                    <td>
                        <button type="submit" class="btn btn-primary waves-button waves-light light-blue" data-toggle="modal" data-target="#myModal3" >Search</button>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 20px; font-family:'Verdana' ">
                        Get the maximum amount earned through a single booking in a given year
                    </td>
                    <td>
                        <button type="submit" class="btn btn-primary waves-button waves-light light-blue" data-toggle="modal" data-target="#myModal4" >Search</button>
                    </td>
                </tr>


                </tbody>
            </table>

            <!-- Modal -->
            <div id="myModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Modal Header</h4>
                        </div>
                        <form:form action="/findAmountForMonthEachLocation" method="post">
                           <div style="display: inline-block">
                               <select name="month" id="month">
                                   <option selected>--Select Month--</option>
                                   <option>January</option>
                                   <option>February</option>
                                   <option>March</option>
                                   <option>April</option>
                                   <option>May</option>
                                   <option>June</option>
                                   <option>July</option>
                                   <option>August</option>
                                   <option>September</option>
                                   <option>October</option>
                                   <option>November</option>
                                   <option>December</option>

                               </select>

                               <select name="year" id="year">
                                   <option selected>--Select Year--</option>
                                   <option>2018</option>
                                   <option>2019</option>
                               </select>
                           </div>

                            <div class="grid center-div">
                                <button type="submit" value="Submit"
                                        class="btn btn-primary waves-button waves-light light-blue"
                                        style="width: 240px;">SUBMIT
                                </button>
                            </div>

                        </form:form>
                        <%--<div class="modal-footer">--%>
                            <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                        <%--</div>--%>
                    </div>

                </div>
            </div>

            <div id="myModal2" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Modal Header</h4>
                        </div>
                        <form:form action="/findTotalAmountEarnedByAllLocation" method="post">
                          <div class="form-group-sm">
                              <select   class="form-control" style="margin-top: 5px; margin-left: 5px; margin-right: 20% " name="month" id="month">
                                  <option selected>--Select Month--</option>
                                  <option>January</option>
                                  <option>February</option>
                                  <option>March</option>
                                  <option>April</option>
                                  <option>May</option>
                                  <option>June</option>
                                  <option>July</option>
                                  <option>August</option>
                                  <option>September</option>
                                  <option>October</option>
                                  <option>November</option>
                                  <option>December</option>

                              </select>
                          </div>


                            <select  style="margin-left: 10%" name="year" id="year">
                                <option selected>--Select Year--</option>
                                <option>2018</option>
                                <option>2019</option>
                            </select>

                            <div class="grid center-div">

                            </div>

                        </form:form>
                        <div class="modal-footer">
                            <button type="submit" value="Submit"
                                    class="btn btn-primary waves-button waves-light light-blue"
                                    style="width: 240px; ">Search for both locations
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>

        </section>

            <section id="do_migration" style="margin-top: 5%">
                <form:form cssStyle="float: left" action="/do-migration-migrate" method="post">
                    <div style="float: left; margin-right: 80px;">
                        <input class="btn btn-blue-grey waves-button waves-light" style="width: 240px; height: 40px"
                               type="submit" value="MOVE TO WAREHOUSE"/>
                        <p> Number of rows updated : ${numOfRowsMoved}</p>
                    </div>
                </form:form>
            </section>


    <div id="myModal3" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <form:form action="/findAmountEarnedByEachForiegnerCountry" method="post">


                    <div class="grid center-div">
                        <button type="submit" value="Submit"
                                class="btn btn-primary waves-button waves-light light-blue"
                                style="width: 240px;">Search for both locations
                        </button>
                    </div>

                </form:form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div id="myModal4" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
                <form:form action="/findMaxBookingAmountForMonth" method="post">

                    <select name="month" id="month">
                        <option selected>--Select Month--</option>
                        <option>January</option>
                        <option>February</option>
                        <option>March</option>
                        <option>April</option>
                        <option>May</option>
                        <option>June</option>
                        <option>July</option>
                        <option>August</option>
                        <option>September</option>
                        <option>October</option>
                        <option>November</option>
                        <option>December</option>
                    </select>


                    <div class="grid center-div">
                        <button type="submit" value="Submit"
                                class="btn btn-primary waves-button waves-light light-blue"
                                style="width: 240px;">Search for both locations
                        </button>
                    </div>

                </form:form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</div>





</body>
</html>
