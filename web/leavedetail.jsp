<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>

           <div class="container-scroller">
      <!-- partial:partials/_sidebar.jsp -->
                <jsp:include page="partials/_sidebar.jsp" />
        <%! leave l; Hashtable leaveDetail; %>
        <%
            Hashtable color = new Hashtable();
                color.put("0", "badge-outline-danger");
                color.put("1", "badge-outline-warning");
                color.put("2", "badge-outline-success");
                
                Hashtable status = new Hashtable();
                status.put("0", "Rejected");
                status.put("1", "Pending");
                status.put("2", "Approved");
            
            if(request.getParameter("lid") != null)
            {
                l = new leave(application);
                leaveDetail = l.read(Integer.parseInt(request.getParameter("lid")));
                
                
            }
            else
            {
                response.sendRedirect("leavehistory.jsp");
            }
            %>  

      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.jsp -->
            <jsp:include page="partials/_navbar.jsp" />
          <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
           
                               <div class="row">
                            <!-- Column -->
                            <div class="col-lg-12 col-xlg-12 col-md-12">
                                <div class="card" data-aos="fade-left">
                                    <div class="card-body" data-aos="fade-in">
                                        
                                        <%
                                            if(!leaveDetail.get("status").equals(2))
                                            {
                                            %>
                                        <a class="btn btn-warning" style="position: absolute;padding:15px;right: 27px;top:20px; " href="editleave.jsp?lid=<%= leaveDetail.get("id") %>">
                                            <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                        </a>
                                            
                                            <%
                                        }
                                        %>
                                            
                                            
                                            <h4 class="card-title">Leave Detail</h4>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <tbody>
                                                    <tr>
                                                        <th>Leave From</th>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(leaveDetail.get("fromDate")) %> </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Leave To</th>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(leaveDetail.get("toDate")) %> </td>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Leave Type</th>
                                                        <td colspan="3"> <%= new leavetype(application).read((int)leaveDetail.get("leaveTypeId")).get("leaveType") %> </td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Leave Applied Date</th>
                                                        <td colspan="3"> <%= new SimpleDateFormat("dd-MM-yyyy").format(leaveDetail.get("postingDate")) %> </td>                                        
                                                    </tr>

                                                    <tr>
                                                        <th colspan="1">Leave Condition</th>
                                                        <td colspan="3"><%= leaveDetail.get("description") %></td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Admin Remark</th>
                                                        <td colspan="3"><%= leaveDetail.get("adminRemark") %></td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Admin Remark Date</th>
                                                        <td colspan="3"><%= leaveDetail.get("adminRemarkDate").toString() != "" ? new SimpleDateFormat("dd-MM-yyyy").format(leaveDetail.get("adminRemarkDate")) : "" %></td>                                        
                                                    </tr>    
                                                    
                                                    <tr>
                                                        <th colspan="1">Leave Status</th>
                                                        <td colspan="3">                                                            
                                                            <div class="badge <%= color.get(leaveDetail.get("status").toString()) %>"> <%= status.get(leaveDetail.get("status").toString()) %> </div>
                                                        </td>                                        
                                                    </tr>                                                
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
