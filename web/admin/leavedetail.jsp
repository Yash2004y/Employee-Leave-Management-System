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
        
           <div class="container-scroller">
      <!-- partial:partials/_sidebar.jsp -->
                <jsp:include page="partials/_sidebar.jsp" />
  

      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.jsp -->
            <jsp:include page="partials/_navbar.jsp" />
         <%! 
            employee e;
            department d;
            leave l;
            leavetype lt;
            Hashtable edetail,ddetail,ldetail,ltdetail;
        %>
        <%
            Hashtable color = new Hashtable();
            color.put("0", "badge-outline-danger");
            color.put("1", "badge-outline-warning");
            color.put("2", "badge-outline-success");
            
            Hashtable status = new Hashtable();
            status.put("0", "Rejected");
            status.put("1", "Pending");
            status.put("2", "Approved");
            
            e = new employee(application);
            d = new department(application);
            l = new leave(application);
            lt = new leavetype(application);
            if(request.getParameter("lid") == null)
            {
                response.sendRedirect("index.jsp");
            }
            int lid = Integer.parseInt(request.getParameter("lid"));
            ldetail = l.read(lid);
            edetail = e.read(Integer.parseInt(ldetail.get("eid").toString()));
            ddetail = d.read(Integer.parseInt(edetail.get("deptId").toString()));
            ltdetail = lt.read(Integer.parseInt(ldetail.get("leaveTypeId").toString()));
            if(ldetail.get("isRead").equals(0))
            {
                l.updateRead(lid);
            }
        %>
        <%
            if(session.getAttribute("msg") != null)
            {
                                out.println("<script>swal('"+session.getAttribute("msg")+"','','success')</script>");
                                 session.removeAttribute("msg");
        }
            %>
          <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
                               <div class="row">
                            <!-- Column -->
                            <div class="col-lg-4 col-xlg-3 col-md-5">
                                <div class="card" data-aos="fade-right">
                                    <div class="card-body" data-aos="fade-in">

                                            <center class="m-t-30"> 
                                            <%  String img = "../empimages/" + edetail.get("img"); %>
                                            <div data-aos="zoom-in" style="background: url('<%= img %>');height:170px;background-size:85% 85%;width:170px;background-repeat:no-repeat;background-position:center center;"></div>
                                            <h4 class="card-title m-t-10" data-aos="zoom-out" ><%= edetail.get("name") %></h4>
                                            <h6 class="card-subtitle" data-aos="zoom-out" ><%= edetail.get("deptName") %></h6>
                                        </center>
                                    </div>
                                    <div class="card-body" data-aos="zoom-out" > 
                                        <small class="text-muted">Email address </small>
                                        <h6><%= edetail.get("emailId") %></h6> 

                                        <small class="text-muted p-t-30 db">Phone</small>
                                        <h6>+91 <%= edetail.get("mobileNo") %></h6> 

                                        <%

                                            String dob = new SimpleDateFormat("dd-MM-yyyy").format(edetail.get("dob"));
                                        %>
                                        <small class="text-muted p-t-30 db">DOB</small>
                                        <h6><%= dob %></h6> 
    
                                        <small class="text-muted p-t-30 db">Gender</small>
                                        <h6><%= edetail.get("gender") %></h6> 
                                        
                                        <small class="text-muted p-t-30 db">Address</small>
                                        <h6><%= edetail.get("address") %></h6>
                                        
                                        <small class="text-muted p-t-30 db">Registration Date</small>
                                        <h6><%= new SimpleDateFormat("dd-MM-yyyy | HH:mm:ss").format(edetail.get("regDate")) %></h6> 

                                        
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
                                        <div class="row">
                                            <div class="col">
                                                <h4 class="card-title">Leave Detail</h4>
                                            </div>
                                            <div class="col">
                                                <button class="btn btn-danger float-right" title="Change Status" data-ttitle="tooltip" data-placement="bottom" style="position: relative;padding:15px;" data-toggle="modal" data-target="#chgstatus">
                                                    <i class="fa-solid fa-arrows-rotate" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                </button> 
                                            </div>
                                        </div>
                                        </p>
         
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <tbody>
                                                     <tr>
                                                        <th>Leave From</th>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("fromDate")) %> </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Leave To</th>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("toDate")) %> </td>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Leave Type</th>
                                                        <td colspan="3"> <%= ltdetail.get("leaveType") %> </td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Leave Applied Date</th>
                                                        <td colspan="3"> <%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("postingDate")) %> </td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Leave Condition</th>
                                                        <td colspan="3"><%= ldetail.get("description") %></td>                                        
                                                    </tr>
                                                    <tr>
                                                        <th colspan="1">Admin Remark</th>
                                                        <td colspan="3"><%= ldetail.get("adminRemark") %></td>                                        
                                                    </tr>

                                                    <tr>
                                                        <th colspan="1">Admin Remark Date</th>
                                                        <td colspan="3"><%= ldetail.get("adminRemarkDate").toString() != "" ? new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("adminRemarkDate")) : "" %></td>                                        
                                                    </tr>    
                                                    
                                                    <tr>
                                                        <th colspan="1">Leave Status</th>
                                                        <td>
                                                            <div class="badge <%= color.get(ldetail.get("status").toString()) %>"> <%= status.get(ldetail.get("status").toString()) %> </div>
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

<div class="modal fade" id="chgstatus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Change Status</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="chgstatus" action="#" method="post" onsubmit="return valid()">
                            <div class="form-group">
                                <label for="status" class="col-form-label">Status</label>
                                <select class="form-control form-select" id="status" name="status">
                                    <option value="1" selected>Pending</option>
                                    <option value="2">Approve</option>
                                    <option value="0">Reject</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="aremark" class="col-form-label">Admin Remark</label>
                                <textarea id="aremark" name="aremark" class="form-control" rows="4"></textarea>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-warning" value="chgstatus" name="chgstatus">Change Status</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            if(request.getParameter("chgstatus") != null)
            {
                String astatus = request.getParameter("status");
                String aremark = request.getParameter("aremark");
                String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString();
                int row = l.updateStatus(lid, Integer.parseInt(astatus), aremark, today);
                if(row > 0)
                {
                    session.setAttribute("msg", "Successfully Status Changed");
                    out.println("<script>window.location.href='leavedetail.jsp?lid="+lid+"'</script>");
                }
            }
        %>
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
