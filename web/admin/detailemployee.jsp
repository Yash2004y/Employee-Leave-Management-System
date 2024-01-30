<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="java.text.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>

        <%! 
            employee e;
            department d;
            Hashtable emp;
        %>
        <%
            e = new employee(application);
            d = new department(application);
            if(request.getParameter("eid") != null)
            {
                emp = e.read(Integer.parseInt(request.getParameter("eid")));
                if(emp.isEmpty())
                {
                    out.println("<script>window.location.href='allemployee.jsp'</script>");
                }
            }
            else
            {
                  out.println("<script>window.location.href='allemployee.jsp'</script>");
              
            }       
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
                            <!-- Column -->
                            <div class="col-lg-4 col-xlg-3 col-md-5">
                                <div class="card" data-aos="fade-right">
                                    <div class="card-body" data-aos="fade-in">
                                        
                                        <a class="btn btn-primary" href="allemployee.jsp" style="position: absolute;padding:15px;left: 10px;top:10px; " data-aos="zoom-in">
                                            <i class="fa-solid fa-arrow-left" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                        </a>
                                        
                                        <a class="btn btn-warning" href="editemployee.jsp?eid=<%= emp.get("eid") %>" style="position: absolute;padding:15px;right: 10px;top:10px;" data-aos="zoom-in">
                                            <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                        </a>

                                            <center class="m-t-30"> 
                                            <%  String img = "../empimages/" + emp.get("img"); %>
                                            <div data-aos="zoom-in" style="background: url('<%= img %>');height:170px;background-size:85% 85%;width:170px;background-repeat:no-repeat;background-position:center center;"></div>
                                            <h4 class="card-title m-t-10" data-aos="zoom-out" ><%= emp.get("name") %></h4>
                                            <h6 class="card-subtitle" data-aos="zoom-out" ><%= emp.get("deptName") %></h6>
                                        </center>
                                    </div>
                                    <div class="card-body" data-aos="zoom-out" > 
                                        <small class="text-muted">Email address </small>
                                        <h6><%= emp.get("emailId") %></h6> 

                                        <small class="text-muted p-t-30 db">Phone</small>
                                        <h6>+91 <%= emp.get("mobileNo") %></h6> 

                                        <%

                                            String dob = new SimpleDateFormat("dd-MM-yyyy").format(emp.get("dob"));
                                        %>
                                        <small class="text-muted p-t-30 db">DOB</small>
                                        <h6><%= dob %></h6> 
    
                                        <small class="text-muted p-t-30 db">Gender</small>
                                        <h6><%= emp.get("gender") %></h6> 
                                        
                                        <small class="text-muted p-t-30 db">Address</small>
                                        <h6><%= emp.get("address") %></h6>
                                        
                                        <small class="text-muted p-t-30 db">Registration Date</small>
                                        <h6><%= new SimpleDateFormat("dd-MM-yyyy | HH:mm:ss").format(emp.get("regDate")) %></h6> 

                                        
                                        <small class="text-muted p-t-30 db">Social Profile</small>
                                        <br />

                                        <button class="btn btn-circle btn-secondary p-2"><i class="fab fa-facebook-f"></i></button>
                                        <button class="btn btn-circle btn-secondary p-2"><i class="fab fa-twitter"></i></button>
                                        <button class="btn btn-circle btn-secondary p-2"><i class="fab fa-youtube"></i></button>
                                    </div>
                                </div>
                            </div>
                            <!-- Column -->
                            <!-- Column -->
                            <div class="col-lg-8 col-xlg-9 col-md-7">
                                <div class="card" data-aos="fade-left">
                                    <div class="card-body" data-aos="fade-in">
                                        <h4 class="card-title">Leaves</h4>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped text-center">
                                                <thead>
                                                    <tr>
                                                        <th> ID </th>
                                                        <th> Leave Type </th>
                                                        <th> From Date </th>
                                                        <th> To Date </th>
                                                        <th> Applied Date </th>
                                                        <th> Status </th>
                                                        <th> Action </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Hashtable color = new Hashtable();
                                                        color.put("0", "badge-outline-danger");
                                                        color.put("1", "badge-outline-warning");
                                                        color.put("2", "badge-outline-success");
                                                        
                                                        Hashtable status = new Hashtable();
                                                        status.put("0", "Rejected");
                                                        status.put("1", "Pending");
                                                        status.put("2", "Approved");
                                                        leave l = new leave(application);
                                                        Vector v = l.readAllEmpLeaveId(Integer.parseInt(request.getParameter("eid")));
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                        Hashtable ldetail = l.read((int)v.get(i));
                                                            %>
                                                    <tr data-aos="zoom-in">
                                                        <td> <%= ldetail.get("id") %> </td>
                                                        <td> <%= new leavetype(application).read(Integer.parseInt(ldetail.get("leaveTypeId").toString())).get("leaveType") %> </td>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("fromDate")) %> </td>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("toDate")) %> </td>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("postingDate")) %> </td>
                                                        <td> 
                                                            <div class="badge <%= color.get(ldetail.get("status").toString()) %>"> <%= status.get(ldetail.get("status").toString()) %> </div>
                                                        </td>
                                                        <td> 
                                                            <a class="btn btn-primary" href="leavedetail.jsp?lid=<%= ldetail.get("id") %>" style="position: relative;padding:15px;">
                                                                <i class="mdi mdi-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </a>
                                                        </td>
                                                    </tr>        
                                                            <%
                                                    }
                                                        
                                                        %>
                                                    
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Column -->
                        </div>

                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.jsp -->
                    <%@include file="partials/_footer.jsp" %>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <%@include file="partials/scriptfile.jsp" %>
    </body>
</html>
