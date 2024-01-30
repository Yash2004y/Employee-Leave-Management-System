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
  

      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_navbar.jsp -->
            <jsp:include page="partials/_navbar.jsp" />
          <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
           
              <div class="row" data-aos="fade-up">

                            <div class="col-lg-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body" data-aos="fade-in">
                                        <div class="row">
                                            <div class="col">
                                                <p>
                                                <h4 class="card-title" data-aos="zoom-in">Leaves History</h4>
                                                </p>        
                                            </div>
                                            <div class="col">
                                                <input type="text" data-aos="zoom-in" id="search" placeholder="Search" class="form-control text-secondary" onkeyup="search(this)" onkeydown="search(this)" onkeypress="search(this)">
                                            </div>

                                        </div>

                                        <div class="table-responsive">
                                            <table class="table text-center table-striped" data-aos="zoom-in" id="dataTable" id="searchtable">
                                                <thead>
                                                    <tr>
                                                        <th> ID </th>
                                                        <th> Leave Type</th>
                                                        <th> From Date </th>
                                                        <th> To Date </th>
                                                        <th> Apply Date </th>
                                                        <th> status </th>
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
                                                        Vector v = l.readAllEmpLeaveId((int)session.getAttribute("empId"));
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            Hashtable ldetail = l.read((int)v.get(i));
                                                            leavetype ltype = new leavetype(application);
                                                            Hashtable ltdetail = ltype.read((int)ldetail.get("leaveTypeId"));
                                                    %>
                                                    <tr>
                                                        <td><%= ldetail.get("id") %></td>
                                                        <td><%= ltdetail.get("leaveType") %></td>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("fromDate")) %>
                                                        </td>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("toDate")) %></td>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(ldetail.get("postingDate")) %></td>
                                                        <td>
                                                            <div class="badge <%= color.get(ldetail.get("status").toString()) %>"> <%= status.get(ldetail.get("status").toString()) %> </div>
                                                        </td>
                                                        <td> 
                                                            <a class="btn btn-primary" style="position: relative;padding:15px;" href="leavedetail.jsp?lid=<%= ldetail.get("id") %>">
                                                                <i class="mdi mdi-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </a>
                                                            <% if(!ldetail.get("status").equals(2))
                                                            {
                                                            %>
                                                                <a class="btn btn-warning" style="position: relative;padding:15px;" href="editleave.jsp?lid=<%= ldetail.get("id") %>">
                                                                    <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                                </a>
                                                            
                                                            <%
                                                            }
                                                              %>
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

                        </div>

            <script>
                     function search(input)
            {
                table = document.getElementsByTagName("table")[0];
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++)
                {
                    lid = tr[i].getElementsByTagName("td")[0].innerText.toLowerCase();
                    ltype = tr[i].getElementsByTagName("td")[1].innerText.toLowerCase();
                    fdate = tr[i].getElementsByTagName("td")[2].innerText.toLowerCase();
                    tdate = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    adate = tr[i].getElementsByTagName("td")[4].innerText.toLowerCase();
                    status = tr[i].getElementsByTagName("td")[5].innerText.toLowerCase();
                    inputval = input.value.toLowerCase();
                    if (lid.match(inputval) || ltype.match(inputval) || fdate.match(inputval) || tdate.match(inputval) || adate.match(inputval) || status.match(inputval))
                    {
                        tr[i].style.display = "";
                    } else
                    {
                        tr[i].style.display = "none";
                    }

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