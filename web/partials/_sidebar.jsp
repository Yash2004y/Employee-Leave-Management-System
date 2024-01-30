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
<nav class="sidebar sidebar-offcanvas" id="sidebar">
  <div class="sidebar-brand-wrapper d-none d-lg-flex align-items-center justify-content-center fixed-top">
    <a class="sidebar-brand brand-logo" href="index.jsp"><img src="assets/images/elms-logo/png/logo.png" alt="logo" /></a>
    <a class="sidebar-brand brand-logo-mini" href="index.jsp"><img src="assets/images/elms-logo/png/logo-mini.png" style="width: 35px;height: 35px;" alt="logo" /></a>
  </div>

  <ul class="nav">
    <li class="nav-item profile">
      <div class="profile-desc">
        <div class="profile-pic">
          <div class="count-indicator">
            <img class="img-xs rounded-circle " src="empimages/<%= emp.get("img") %>" alt="" data-aos="flip-left" data-aos-duration="900">
            <span class="count bg-success"></span>
          </div>
          <div class="profile-name">
              <h5 class="mb-0 font-weight-normal"><%= emp.get("name") %></h5>
            <span><%= emp.get("emailId") %></span>
          </div>
        </div>
        <a href="#" id="profile-dropdown" data-toggle="dropdown"><i class="mdi mdi-dots-vertical"></i></a>
        <div class="dropdown-menu dropdown-menu-right sidebar-dropdown preview-list" aria-labelledby="profile-dropdown">
          <a href="profile.jsp" class="dropdown-item preview-item">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-dark rounded-circle">
                <i class="mdi mdi-account text-primary"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <p class="preview-subject ellipsis mb-1 text-small">Profile</p>
            </div>
          </a>
          <div class="dropdown-divider"></div>
           <a class="dropdown-item preview-item"href="logout.jsp">
            <div class="preview-thumbnail">
              <div class="preview-icon bg-dark rounded-circle">
                <i class="mdi mdi-logout  text-info"></i>
              </div>
            </div>
            <div class="preview-item-content">
              <p class="preview-subject ellipsis mb-1 text-small">Logout</p>
            </div>
          </a>
          <div class="dropdown-divider"></div>
        </div>
      </div>
    </li>
    <li class="nav-item nav-category">
      <span class="nav-link">Navigation</span>
    </li>
    <li class="nav-item menu-items">
      <a class="nav-link" href="index.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-speedometer"></i>
        </span>
        <span class="menu-title">Dashboard</span>
      </a>
    </li>
        <li class="nav-item menu-items">
      <a class="nav-link" href="applyleave.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-logout"></i>
        </span>
        <span class="menu-title">Apply Leave</span>
      </a>
    </li>
    <li class="nav-item menu-items">
      <a class="nav-link" href="leavehistory.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-clock"></i>
        </span>
        <span class="menu-title">Leave History</span>
      </a>
    </li>
  </ul>
</nav>