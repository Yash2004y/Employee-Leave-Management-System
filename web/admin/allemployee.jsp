<%-- 
    Document   : addemployee
    Created on : 22-Nov-2023, 11:58:43 am
    Author     : Chauhan Yash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>
        <%! employee e; %>
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

                        <%
                            if(session.getAttribute("msg") != null)
                            {
                                out.println("<script>swal('"+session.getAttribute("msg")+"','','success')</script>");
                                session.removeAttribute("msg");
                            }
                            %>
                        
                        <div class="row" data-aos="fade-down">
                            <div class="col-12 grid-margin">
                                <a class="btn btn-outline-danger btn-icon-text float-right" href="addemployee.jsp"><i class="mdi mdi-account-plus btn-icon-prepend icon-large"></i> ADD EMPLOYEE </a>                            
                            </div>
                        </div>

                        <div class="row" data-aos="fade-up">

                            <div class="col-lg-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">
                                        
                                        <div class="row">
                                            <div class="col">
                                                <p>
                                                <h4 class="card-title" data-aos="zoom-in">All Employees</h4>
                                                </p>        
                                            </div>
                                            <div class="col">
                                                <input type="text" data-aos="zoom-in" id="search" placeholder="Search" class="form-control text-secondary" onkeyup="search(this)" onkeydown="search(this)" onkeypress="search(this)">
                                            </div>

                                        </div>
                                        
                                        <div class="table-responsive">
                                            <table class="table table-striped text-center" data-aos="zoom-in">
                                                <thead>
                                                    <tr>
                                                        <th> EID </th>
                                                        <th> Employee Name</th>
                                                        <th> Email </th>
                                                        <th> Department </th>
                                                        <th> Mobile NO. </th>
                                                        <th> Image </th>
                                                        <th> Action </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        e = new employee(application);
                                                        Vector v = e.readAllId();
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            Hashtable h = e.read((int)v.get(i));
                                                        %>
                                                    <tr>
                                                        <td> <%= h.get("eid") %> </td>
                                                        <td> 
                                                            <span class="pl-2"><%= h.get("name") %></span>                            
                                                        </td>
                                                        <td> <%= h.get("emailId") %> </td>
                                                        <td> <%= h.get("deptName") %> </td>
                                                        <td> <%= h.get("mobileNo") %> </td>
                                                        <td>
                                                            <img data-aos="flip-left" data-aos-offset="30" data-aos-duration="1000" src="../empimages/<%= h.get("img") %>" style="height:40px;width:40px;" alt="image" />
                                                        </td>
                                                        <td> 
                                                            <a class="btn btn-primary" href="detailemployee.jsp?eid=<%= h.get("eid") %>" style="position: relative;padding:15px;">
                                                                <i class="mdi mdi-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </a>
                                                            <a class="btn btn-warning" href="editemployee.jsp?eid=<%= h.get("eid") %>" style="position: relative;padding:15px;">
                                                                <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </a>
                                                            <button class="btn btn-danger" style="position: relative;padding:15px;" onclick="deletemodal(this)" eid="<%= h.get("eid") %>" ename="<%= h.get("name") %>"  data-toggle="modal" data-target="#deletemodal">
                                                                <i class="mdi mdi-delete" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </button>
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

                    </div>
                                                    <div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Are You Sure Delete This Employee ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="deleteemp" action="#" method="get">
                            <div class="form-group">
                                <label for="deletedname" class="col-form-label">Employee Name</label>
                                <input type="text" class="form-control text-dark" id="deleteename" name="deleteename" autofocus disabled>
                            </div>
                            <input type="hidden" id="deleteeid" name="deleteeid" value=""/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="deptdelete" name="delete">Delete</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            if(request.getParameter("delete") != null)
            {
                int eid = Integer.parseInt(request.getParameter("deleteeid"));
//                out.println("EID = " + eid );
                int row = e.delete(eid);
                if(row > 0)
                {
                    session.setAttribute("msg","Employee Successfully Deleted");
                }
            }
        %>
        <script>
            function deletemodal(btn)
            {
                eid = btn.getAttribute("eid");
                ename = btn.getAttribute("ename");
                $("#deleteename").val(ename);
                $("#deleteeid").val(eid);
            }
            function search(input)
            {
                table = document.getElementsByTagName("table")[0];
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++)
                {
                    eid = tr[i].getElementsByTagName("td")[0].innerText.toLowerCase();
                    ename = tr[i].getElementsByTagName("td")[1].innerText.toLowerCase();
                    email = tr[i].getElementsByTagName("td")[2].innerText.toLowerCase();
                    dname = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    mobno = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    inputval = input.value.toLowerCase();
                    if (eid.match(inputval) || ename.match(inputval) || email.match(inputval) || dname.match(inputval)  ||  mobno.match(inputval))
                    {
                        tr[i].style.display = "";
                    } else
                    {
                        tr[i].style.display = "none";
                    }

                }

            }
        </script>
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
