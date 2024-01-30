<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
      <%@include file="partials/headerfile.jsp" %>
  </head>
  <body>
      <%! employee e;
          department d;
          admin a;
          leavetype l;
          leave empLeave;
          %>
          <%
              e = new employee(application);
              d = new department(application);
              a = new admin(application);
              empLeave = new leave(application);
              l = new leavetype(application);
              %>
    <div class="container-scroller">
      <!-- partial:partials/_sidebar.jsp -->
      
      <jsp:include page="partials/_sidebar.jsp" />
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.jsp -->
      <jsp:include page="partials/_navbar.jsp" />

        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
           
            <div class="row">
                
                <div class="col-sm-4 grid-margin">
                <div class="card" data-aos="fade-down-right">
                  <div class="card-body">
                    <h5>Total Department</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= d.readAllId().size() %></h2>
                          <!--<p class="text-success ml-2 mb-0 font-weight-medium">+8.3%</p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal"> 9.61% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg mdi mdi-view-grid fa-solid text-danger ml-auto" data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              

              <div class="col-sm-4 grid-margin">
                <div class="card" data-aos="zoom-in">
                  <div class="card-body">
                    <h5>Total Employees</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= e.readAllId().size() %></h2>
                          <!--<p class="text-success ml-2 mb-0 font-weight-medium"></p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal">11.38% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg mdi mdi-account-multiple fa-solid text-primary ml-auto" data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-sm-4 grid-margin">
                <div class="card" data-aos="fade-down-left">
                  <div class="card-body">
                    <h5>Total Leave Types</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= l.readAllId().size() %></h2>
                          <!--<p class="text-success ml-2 mb-0 font-weight-medium">+8.3%</p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal"> 9.61% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg mdi mdi-logout-variant fa-solid text-warning ml-auto"  data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-sm-3 grid-margin">
                <div class="card" data-aos="fade-right">
                  <div class="card-body">
                    <h5>Total Leaves</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= empLeave.readAllId().size() %></h2>
                          <!--<p class="text-danger ml-2 mb-0 font-weight-medium">-2.1% </p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal">2.27% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                          <i class="icon-lg fa-solid fa-right-to-bracket text-success ml-auto"  data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
                          <div class="col-sm-3 grid-margin" style="height: inherit;">
                <div class="card" data-aos="zoom-in">
                  <div class="card-body">
                    <h5>Total Pending Leaves</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= empLeave.readAllPendingId().size() %></h2>
                          <!--<p class="text-danger ml-2 mb-0 font-weight-medium">-2.1% </p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal">2.27% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg fa-spinner fa-solid text-info ml-auto" data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
                          <div class="col-sm-3 grid-margin">
                <div class="card" data-aos="zoom-in">
                  <div class="card-body">
                    <h5>Total Approved Leaves</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= empLeave.readAllApprovedId().size() %></h2>
                          <!--<p class="text-danger ml-2 mb-0 font-weight-medium">-2.1% </p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal">2.27% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg fa-solid fa-check-circle text-success ml-auto" data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
                          <div class="col-sm-3 grid-margin">
                <div class="card" data-aos="fade-left">
                  <div class="card-body">
                    <h5>Total Rejected Leaves</h5>
                    <div class="row">
                      <div class="col-8 col-sm-12 col-xl-8 my-auto">
                        <div class="d-flex d-sm-block d-md-flex align-items-center">
                          <h2 class="mb-0"><%= empLeave.readAllRejectedId().size() %></h2>
                          <!--<p class="text-danger ml-2 mb-0 font-weight-medium">-2.1% </p>-->
                        </div>
                        <!--<h6 class="text-muted font-weight-normal">2.27% Since last month</h6>-->
                      </div>
                      <div class="col-4 col-sm-12 col-xl-4 text-center text-xl-right">
                        <i class="icon-lg fa-solid fa-times-circle text-danger ml-auto" data-aos="zoom-in"></i>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>  
                          <%
                              if(!empLeave.readAllUnreadId().isEmpty())
                              {
                              %>
    <div class="row ">
              <div class="col-12 grid-margin">
                <div class="card" data-aos="fade-up">
                  <div class="card-body" data-aos="zoom-in">
                    <h4 class="card-title">Recent Leave Requests</h4>
                    <div class="table-responsive">
                      <table class="table table-striped text-center">
                        <thead>
                          <tr>
                            <th> LID </th>
                            <th> Employee Name </th>
                            <th> Leave Type </th>
                            <th> From Date </th>
                            <th> To Date </th>
                            <th> Applied Date </th>
                            <th> Action </th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                              <%
                                  Vector v = empLeave.readAllUnreadId();
                                  for(int i=0;i<v.size();i++)
                                  {
                                    Hashtable ldetail = empLeave.read((int)v.get(i));
                                    Hashtable emp = e.read((int)ldetail.get("eid"));
                                    Hashtable ltdetail = l.read((int)ldetail.get("leaveTypeId"));
                             %>
                                <td><%= ldetail.get("id") %></td>
                            <td>
                                <img data-aos="flip-left" data-aos-offset="30" data-aos-duration="1000" src="../empimages/<%= emp.get("img") %>" alt="image" />
                                <span class="pl-2"><%= emp.get("name") %></span>
                            </td>
                            <td> <%= ltdetail.get("leaveType") %> </td>
                            <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("fromDate")) %> </td>
                            <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("toDate")) %> </td>
                            <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("postingDate")) %> </td>
                            <td> 
                                                                                            <a class="btn btn-primary" style="position: relative;padding:15px;" href="leavedetail.jsp?lid=<%= ldetail.get("id") %>">
                                                                <i class="mdi mdi-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </a>
                            </td>
                                   
                                   <%
                                  }
                                  %>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
                                      
                              <%
                          }
    %>
    
          </div>
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.jsp -->
          <%--<%@include file="partials/_footer.jsp" %>--%>
          <jsp:include page="partials/_footer.jsp" />
          <!-- partial -->
        </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <%@include file="partials/scriptfile.jsp" %>
  </body>
</html>