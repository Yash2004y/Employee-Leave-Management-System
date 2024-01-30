<%-- 
    Document   : addemployee
    Created on : 22-Nov-2023, 11:58:43 am
    Author     : Chauhan Yash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>

        <%!
            employee e;
            department d;
        %>
        <%
            e = new employee(application);
            d = new department(application);
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

                        <div class="row" data-aos="fade-down">
                            <div class="col-12 grid-margin">
                                <a class="btn btn-outline-primary btn-icon-text" href="allemployee.jsp"><i class="fa-solid fa-arrow-left btn-icon-prepend icon-large"></i> BACK </a>                            
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body" data-aos="zoom-in">
                                        <h4 class="card-title">Add Employee</h4>

                                        <form class="forms-sample" action="#" onsubmit="return valid()" enctype="multipart/form-data" method="post">
                                            <div class="form-group">
                                                <label for="name">Name</label>
                                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter Name" autofocus>
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email address</label>
                                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter Email address">
                                            </div>

                                            <div class="form-group">
                                                <label for="mobno">Mobile NO.</label>
                                                <input type="text" maxlength="10" class="form-control" placeholder="Enter Mobile No." id="mobno" name="mobno">
                                            </div>


                                            <div class="form-group">
                                                <label for="dob">Date Of Birth</label>
                                                <input type="date" class="form-control" id="dob" name="dob">
                                            </div>

                                            <div class="form-group">
                                                <label for="gender">Gender</label>
                                                <select class="form-control" id="gender" name="gender">
                                                    <option value="" selected>Select Gender</option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                            </div>


                                            <div class="form-group">
                                                <label for="deptId">Department</label>
                                                <select class="form-control" id="deptId" name="deptId">
                                                    <option value="" selected>Select Department</option>
                                                    <%
                                                        Vector v = d.readAllId();
                                                        for (int i = 0; i < v.size(); i++) {
                                                            Hashtable h = d.read((int) v.get(i));
                                                    %>
                                                    <option value="<%= h.get("deptId")%>"><%= h.get("deptId")%> - <%= h.get("deptName")%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>


                                            <div class="form-group">
                                                <label for="pimg">Choose Profile Image</label>
                                                <input type="file" name="pimg" id="pimg" class="form-control">
                                            </div>

                                            <div class="form-group">
                                                <label for="address">Address</label>
                                                <textarea class="form-control" id="address" name="address" placeholder="Enter Address" rows="4"></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="pass">Password</label>
                                                <input type="password" class="form-control" id="pass" name="pass" placeholder="Enter Password">
                                            </div>
                                            <div class="form-group">
                                                <div class="form-check form-check-danger">
                                                    <label class="form-check-label">
                                                        <input type="checkbox" class="form-check-input" onchange="show()"> Show Password <i class="input-helper"></i></label>
                                                </div>    
                                            </div>


                                            <button type="submit" class="btn btn-success p-2 q mr-2" name="add">ADD</button>
                                            <button class="btn btn-warning p-2" type="reset">Clear</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
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
        <%
            if (request.getParameter("add") != null) {
                String ename = request.getParameter("name");
                String email = request.getParameter("email");
                String mobno = request.getParameter("mobno");
                String dob = request.getParameter("dob");
                String gender = request.getParameter("gender");
                String deptId = request.getParameter("deptId");

                Part pimg = request.getPart("pimg");
                String pimgName = pimg.getSubmittedFileName();
                String loc = new File(application.getRealPath("/")).getParentFile().getParent() + File.separator + "web" + File.separator + "empimages";

                String address = request.getParameter("address");
                String pass = request.getParameter("pass");
                //out.println(ename + "<br>" + email + "<br>" + mobno + "<br>" + dob + "<br>" + gender + "<br>" + deptId + "<br>" + pimg.getSubmittedFileName() + "<br>" + address + "<br>" + pass);
                try {
                    employee e = new employee(application);
                    if (e.isEmail(email) == 0) {
                        int row = e.add(ename, email, Integer.parseInt(deptId), gender, dob, address, mobno, pass, pimgName);
                        if (row > 0) {
                            pimg.write(loc + File.separator + pimgName);
                            out.println("<script>swal('Employee Successfully Added','','success')</script>");
                        }
                    } else {
                        out.println("<script>swal('Your Given Email Address Already Available','','error')</script>");
                    }

                } catch (Exception e) {
                    out.println(e);
                }
            }
        %>


        <script>
            function show()
            {
                pass = $("#pass");
                if (pass.attr("type") == "password")
                {
                    pass.attr("type", "text");
                } else
                {
                    pass.attr("type", "password");
                }
            }
            function valid()
            {

                ename = $("#name");
                email = $("#email");
                mobno = $("#mobno");
                dob = $("#dob");
                gender = $("#gender");
                deptId = $("#deptId");
                pimg = $("#pimg");
                address = $("#address");
                pass = $("#pass");
                year = new Date().getFullYear() - new Date(Date.parse(dob.val())).getFullYear();
                fileType = pimg.val().split(".")[1];
                if (ename.val().trim() == "")
                {
                    return swalalert("Please Enter Employee Name", "", "error", ename);
                } else if (ename.val().trim().match("[0-9]"))
                {
                    return swalalert("Number Not Allow In Name", "", "error", ename);
                } else if (email.val().trim() == "")
                {
                    return swalalert("Please Enter Email Address", "", "error", email);
                } else if (mobno.val().trim() == "")
                {
                    return swalalert("Please Enter Mobile NO.", "", "error", mobno);
                } else if (!mobno.val().trim().match("[0-9]{10}"))
                {
                    return swalalert("Please Enter Valid Mobile No", "", "error", mobno);
                } else if (dob.val().trim() == "")
                {
                    return swalalert("Please Select Date Of Birth", "", "error", dob);
                } else if (year < 18)
                {
                    return swalalert("Age Must Be Grater Than 18", "", "error", dob);
                } else if (gender.val().trim() == "")
                {
                    return swalalert("Please Select Gender", "", "error", gender);
                } else if (deptId.val().trim() == "")
                {
                    return swalalert("Please Select Department", "", "error", deptId);
                } else if (pimg.val().trim() == "")
                {
                    return swalalert("Please Select Profile Image", "", "error", pimg);
                } else if (!fileType.match("[jpg|jpeg|png]"))
                {
                    return swalalert("Only JPG, JPEG, PNG Format Allow For Profile Image", "", "error", pimg);
                } else if (address.val().trim() == "")
                {
                    return swalalert("Please Enter Address", "", "error", address);
                } else if (pass.val().trim() == "")
                {
                    return swalalert("Please Enter Password", "", "error", pass);
                } else
                {
                    return true;
                }
            }
        </script>

        <%@include file="partials/scriptfile.jsp" %>
    </body>
</html>
