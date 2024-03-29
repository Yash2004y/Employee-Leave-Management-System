<%@page import="elms.*" %>
<%@page import="java.util.*" %>
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
          <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
           
              <div class="row">
                  <div class="card" data-aos="fade-up">
                  <div class="card-body" data-aos="zoom-out">
                    <h4 class="card-title">New Leave Form</h4>
                    <p class="card-description"> Please fill up the form below </p>
                    <form class="forms-sample" method="post" action="#" onsubmit="return valid()">
                      <div class="form-group">
                        <label for="sdate">Start Date</label>
                        <input type="date" class="form-control" id="sdate" name="sdate" autofocus>
                      </div>
                      <div class="form-group">
                        <label for="edate">End Date</label>
                        <input type="date" class="form-control" id="edate" name="edate">
                      </div>
                      <div class="form-group">
                        <label for="ltype">Your Leave Type</label>
                        <select class="form-control" id="ltype" name="ltype">
                            <option value="">Select Leave Type</option>
                            <%
                                leavetype l = new leavetype(application);
                                Vector v = l.readAllId();
                                for(int i=0;i<v.size();i++)
                                {
                                    Hashtable h = l.read((int)v.get(i));
                                    %>
                                    <option value="<%= h.get("leaveTypeId") %>"><%= h.get("leaveTypeId") %> - <%= h.get("leaveType") %></option>
                                    <%
                                }
                                
                                %>
                        </select>
                      </div>

                      <div class="form-group">
                        <label for="dlcon">Describe Leave Condition</label>
                        <textarea class="form-control" name="dlcon" id="dlcon" rows="4"></textarea>
                      </div>
                      <button type="submit" class="btn btn-success mr-2" name="apply">Apply</button>
                      <button type="reset" class="btn btn-warning">Clear</button>
                    </form>
                  </div>
                </div>
              </div>
                <%
                    if(request.getParameter("apply") != null)
                    {
                        int leaveTypeId;
                        String fromDate,toDate,description;
                        fromDate = request.getParameter("sdate");
                        toDate = request.getParameter("edate");
                        leaveTypeId = Integer.parseInt(request.getParameter("ltype"));
                        description = request.getParameter("dlcon");
                        
//                        out.println(fromDate + "<br>" + toDate + "<br>" + leaveTypeId + "<br>" + description);
                        
                        leave leave = new leave(application);
                        int row = leave.add((int)session.getAttribute("empId"), leaveTypeId, fromDate, toDate, description);
                        if(row > 0)
                        {
                            out.println("<script>swal('Your Leave Successfully Applied','','success')</script>");
                        }
                    }
                                    
                %>
                                <script>
                    function valid()
                    {
                        sdate = $("#sdate");
                        edate = $("#edate");
                        ltype = $("#ltype");
//                        dlcon = $("#dlcon");
                        startd = new Date(sdate.val());
                        endd = new Date(edate.val());
                        if(sdate.val() == "")
                        {
                            return swalalert("Please enter leave start date","","error",sdate);
                        }
                        else if(edate.val() == "")
                        {
                            return swalalert("Please enter leave end date","","error",edate);
                        }
                        else if(endd < startd)
                        {
                            return swalalert("Leave end date must after or same as start date","","error",edate);
                        }
                        else if(ltype.val() == "")
                        {
                            return swalalert("Please select leave type","","error",ltype);
                        }
                        else
                        {
                            return true;
                        }
                        
                    }
                    
                    </script>
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
