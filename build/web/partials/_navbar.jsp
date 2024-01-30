<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%! employee e; Hashtable emp; %>
<%
    if(session.getAttribute("empId") == null)
    {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

%>
<%
    e = new employee(application);
    emp = e.read((int)session.getAttribute("empId"));
    %>
<nav class="navbar p-0 fixed-top d-flex flex-row">
  <div class="navbar-brand-wrapper d-flex d-lg-none align-items-center justify-content-center">
    <a class="navbar-brand brand-logo-mini" href="index.jsp"><img src="assets/images/logo-mini.svg" alt="logo" /></a>
  </div>
    <div class="navbar-menu-wrapper flex-grow d-flex align-items-stretch">
    <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
      <span class="mdi mdi-menu"></span>
    </button>
        <ul class="navbar-nav w-100" style="position:relative;">
            <li class="nav-item w-100"  data-aos="fade-in" >
                <div class="nav-heading">Employee Leave Management System</div>
          <div class="nav-heading-mini">ELMS</div>
      </li>
    </ul>
    <ul class="navbar-nav navbar-nav-right">

      <li class="nav-item dropdown">
        <a class="nav-link" id="profileDropdown" href="#" data-toggle="dropdown">
          <div class="navbar-profile">
            <img class="img-xs rounded-circle" src="empimages/<%= emp.get("img") %>" data-aos-duration="900" alt="" data-aos="flip-left">
            <p class="mb-0 d-none d-sm-block navbar-profile-name"><%= emp.get("name") %></p>
            <i class="mdi mdi-menu-down d-none d-sm-block"></i>
          </div>
        </a>
        <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="profileDropdown">
          <div class="dropdown-divider"></div>
          <a class="dropdown-item preview-item" href="profile.jsp">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-dark rounded-circle">
                <i class="mdi mdi-account text-success"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <p class="preview-subject mb-1">Profile</p>
            </div>
          </a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item preview-item" href="logout.jsp">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-dark rounded-circle">
                <i class="mdi mdi-logout text-danger"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <p class="preview-subject mb-1">Log out</p>
            </div>
          </a>
                <div class="dropdown-divider"></div>

        </li>

    </ul>
    <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
      <span class="mdi mdi-format-line-spacing"></span>
    </button>
  </div>
</nav>