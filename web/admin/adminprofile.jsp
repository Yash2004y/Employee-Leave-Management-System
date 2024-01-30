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
        <%
            if(session.getAttribute("msg") != null)
            {
            out.println("<script>swal('"+session.getAttribute("msg")+"','','success')</script>");
        }
            %>
        <div class="container-scroller">
            <!-- partial:partials/_sidebar.jsp -->
            <jsp:include page="partials/_sidebar.jsp" />

            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_navbar.jsp -->
                <%--<%@include file="partials/_navbar.jsp" %>--%>
                <jsp:include page="partials/_navbar.jsp" />
<%! admin a;
    Hashtable admin;%>
<%
    a = new admin(application);
    admin = a.read((int) session.getAttribute("adminId"));
%>
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row" data-aos="fade-down">
                            <div class="col-12 grid-margin">
                                <a class="btn btn-outline-primary btn-icon-text" href="index.jsp"><i class="fa-solid fa-arrow-left btn-icon-prepend icon-large"></i> BACK </a>                            
                            </div>
                        </div>


                        <div class="row">
                            <!-- Column -->
                            <div class="col-lg-12 col-xlg-3 col-md-5">
                                <div class="card" data-aos="fade-up">
                                    <div class="card-body" data-aos="fade-in">

                                        <button class="btn btn-warning" style="position: absolute;padding:15px;right: 27px;top:20px; " onclick="editprofile(this)" aname="<%= admin.get("name") %>" aemail="<%= admin.get("emailId") %>" apass="<%= admin.get("pass") %>" data-toggle="modal" data-target="#editprofile">
                                            <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                        </button>
                                            
                                            

                                        <h4 class="card-title">Admin Profile</h4>
                                        </p>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered" data-aos="zoom-in">
                                                <tbody>
                                                    <tr>
                                                        <th>Admin ID</th>
                                                        <td><%= admin.get("id")%></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Admin Name</th>
                                                        <td><%= admin.get("name")%></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Admin Email address</th>
                                                        <td><%= admin.get("emailId")%></td>
                                                    </tr>
                                                    <tr>
                                                        <th>Created Date</th>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(admin.get("createdAt"))%></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="modal fade" id="editprofile" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Profile</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="editadmin" action="#" method="post" onsubmit="return valid()">
                            <div class="form-group">
                                <label for="aname" class="col-form-label">Name</label>
                                <input type="text" class="form-control" id="aname" name="aname" placeholder="Enter Name" >
                            </div>
                            <div class="form-group">
                                <label for="aemail" class="col-form-label">Email address</label>
                                <input type="email" class="form-control" id="aemail" name="aemail" placeholder="Enter Email address"></input>
                            </div>
                            <div class="form-group" style="position: relative;">
                                <label for="pass" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="pass" name="apass" placeholder="Enter Password"></input>
                                <i type="button" class="btn btn-primary" id="passicon" onclick="chgpass()" style="position: absolute;right:4px;top:37px;padding:15px;"><i class="fa-solid fa-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 15px;" ></i></i>

                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-warning" value="adminedit" name="edit">Update</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            if(request.getParameter("edit") != null)
            {
                String name = request.getParameter("aname");
                String email = request.getParameter("aemail");
                String pass = request.getParameter("apass");
//                out.println(name + "<br>" + email + "<br>" + pass);
                if(a.isEmail(email) == 0 || a.isEmail(email) == Integer.parseInt(admin.get("id").toString()))
                {
                    int row = a.update((int)admin.get("id"), name, email, pass);
                    if(row > 0)
                    {
                        session.setAttribute("msg","Profile Successfully Updated");
                        response.sendRedirect("adminprofile.jsp");
                    }
                }
                else
                {
                    out.println("<script>swal('Your Given Email address Already Available','','error')</script>");
                }
            }

        %>
        <script>
            function editprofile(btn)
            {
                aname = btn.getAttribute("aname");
                aemail = btn.getAttribute("aemail");
                apass = btn.getAttribute("apass");
                
                $("#aname").val(aname);
                $("#aemail").val(aemail);
                $("#pass").val(apass);
            }
            function valid()
            {
                    aname = $("#aname");
                        aemail = $("#aemail");
                        apass = $("#pass");
                        if(aname.val().trim() == "")
                            return swalalert("Please Enter Admin Name","","error",aname);
                        else if(aemail.val().trim() == "")
                            return swalalert("Please Enter Admin Email","","error",aemail);
                        else if(apass.val().trim() == "")
                            return swalalert("Please Enter Password","","error",apass);
                        else
                            return true;
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
