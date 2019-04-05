<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header style="margin-bottom: 60px">
    <nav class="navbar navbar-dark white navbar-fixed-top scrolling-navbar"
         role="navigation">
        <div class="container-fluid" style="">
            <div class="navbar-header">
                <a class="navbar-brand" href="<c:url value="#" />" style="margin-top: -12px">
                    <span  style="font-weight: 800;font-size: 38px; color: #2F2F2F">EMERGING WAREHOUSE</span></a>
            </div>

            <%--<div id="navigation">--%>
                <%--<ul class="nav navbar-nav" style="float: right;">--%>
                    <%--&lt;%&ndash;<li class="nav-item">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a class="nav-link waves-effect waves-light text-muted"&ndash;%&gt;--%>
                           <%--&lt;%&ndash;href="<c:url value="/search-room" />">BOOK ROOM</a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li class="nav-item">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a class="nav-link waves-effect waves-light text-muted"&ndash;%&gt;--%>
                           <%--&lt;%&ndash;href="<c:url value="/rooms" />">ROOMS</a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<li class="nav-item">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<a class="nav-link waves-effect waves-light text-muted"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;href="/#services">SERVICES</a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                    <%--<li class="nav-item">--%>
                        <%--<a class="nav-link waves-effect waves-light text-muted"--%>
                           <%--href="<c:url value="/about" />">ABOUT US</a>--%>
                    <%--</li>--%>

                    <%--&lt;%&ndash;<li class="nav-item">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<a class="nav-link waves-effect waves-light text-muted"&ndash;%&gt;--%>
                    <%--&lt;%&ndash;href="<c:url value="/privacy" />">PRIVACY</a>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>

                    <%--<sec:authorize access="hasRole('ADMIN')">--%>
                        <%--<li class="nav-item">--%>
                            <%--<a href="<c:url value="/admin" />">--%>
                                <%--<button id="admin" type="button"--%>
                                        <%--class="btn-danger waves-button waves-light light-blue"--%>
                                        <%--style="font-weight: 500; font-size: 15px;">ADMIN PANEL--%>
                                <%--</button>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                    <%--</sec:authorize>--%>


                    <%--<sec:authorize access="isAnonymous()">--%>
                        <%--<li class="nav-item">--%>
                            <%--<a href="<c:url value="/login" />">--%>
                                <%--<button id="login" type="button" class="btn-primary waves-button light-blue"--%>
                                        <%--style="width: 120px; font-weight: 500; font-size: 15px">LOGIN--%>
                                <%--</button>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                    <%--</sec:authorize>--%>

                    <%--<sec:authorize access="isAuthenticated()">--%>
                        <%--<li class="nav-item dropdown"--%>
                            <%--style="height: 40px; width: 40px; margin-top: -28.5px; margin-left: 30px;">--%>
                            <%--<a id="dropdownMenu1" data-toggle="dropdown">--%>
                                <%--<img src="<c:url value='/static/images/default_picture.png' /> "--%>
                                     <%--class="img-fluid img-circle">--%>
                            <%--</a>--%>

                            <%--<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1"--%>
                                 <%--data-dropdown-in="fadeIn" data-dropdown-out="fadeOut">--%>
                                <%--<a id="account" class="dropdown-item waves-effect waves-light"--%>
                                   <%--href="<c:url value="/user/profile" />">Profile</a>--%>
                                <%--<a id="logout" class="dropdown-item waves-effect waves-light"--%>
                                   <%--href="<c:url value="/logout" />">Logout</a>--%>
                            <%--</div>--%>
                        <%--</li>--%>
                    <%--</sec:authorize>--%>
                <%--</ul>--%>
            <%--</div>--%>
        </div>
    </nav>
</header>
