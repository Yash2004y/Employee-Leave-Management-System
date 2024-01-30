<%@page import="elms.*" %>
<%@page import="java.util.*" %>

<%! admin a;
    Hashtable h;
    %>
<%
    if(session.getAttribute("adminId") == null)
    {
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        
    }
%>
<%
    a = new admin(application);
    h = a.read((int)session.getAttribute("adminId"));
    
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
            <img class="img-xs rounded-circle " src="assets/images/faces-clipart/pic-4.png" alt="" data-aos="flip-left">
            <span class="count bg-success"></span>
          </div>
          <div class="profile-name">
              <h5 class="mb-0 font-weight-normal"><%= h.get("name") %></h5>
            <span><%= h.get("emailId") %></span>
          </div>
        </div>
        <a href="#" id="profile-dropdown" data-toggle="dropdown"><i class="mdi mdi-dots-vertical"></i></a>
        <div class="dropdown-menu dropdown-menu-right sidebar-dropdown preview-list" aria-labelledby="profile-dropdown">
          <a href="adminprofile.jsp" class="dropdown-item preview-item">
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
      <a class="nav-link" href="alldepartment.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-view-grid"></i>
        </span>
        <span class="menu-title">Departments</span>
      </a>
    </li>
    <li class="nav-item menu-items">
      <a class="nav-link" href="allemployee.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-account-multiple"></i>
        </span>
        <span class="menu-title">Employees</span>
      </a>
    </li>
    <li class="nav-item menu-items">
      <a class="nav-link" href="allleavetype.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-logout-variant"></i>
        </span>
        <span class="menu-title">Leave Types</span>
      </a>
    </li>    
     <li class="nav-item menu-items">
      <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
        <span class="menu-icon">
          <i class="mdi mdi-briefcase"></i>
        </span>
        <span class="menu-title">Manage Leaves</span>
        <i class="menu-arrow"></i>
      </a>
      <div class="collapse" id="ui-basic">
        <ul class="nav flex-column sub-menu">
            <li class="nav-item"> <a class="nav-link" href="pendingleave.jsp"><i class="fa-solid fa-spinner fa-spin-pulse" style="font-size:18px;"></i><i class="pr-2"></i>  Pending</a></li>
          <li class="nav-item"> <a class="nav-link" href="approvedleave.jsp"><i class="fa-solid fa-circle-check" style="font-size:18px;"></i><i class="pr-2"></i> Approved</a></li>
          <li class="nav-item"> <a class="nav-link" href="rejectedleave.jsp"><i class="fa-solid fa-circle-xmark" style="font-size:18px;"></i><i class="pr-2"></i> Rejected</a></li>
          <li class="nav-item"> <a class="nav-link" href="leavehistory.jsp"><i class="fa-solid fa-clock-rotate-left" style="font-size:18px;"></i><i class="pr-2"></i> Leaves History</a></li>
   
        </ul>
      </div>
    </li>
        <li class="nav-item menu-items">
      <a class="nav-link" href="alladmin.jsp">
        <span class="menu-icon">
          <i class="mdi mdi-account-card-details"></i>
        </span>
        <span class="menu-title">Manage Admin</span>
      </a>
    </li>
  </ul>
</nav>