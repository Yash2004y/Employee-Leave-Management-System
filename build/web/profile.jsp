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
                <!-- partial -->
                
        <%
            employee e = new employee(application);
            department d = new department(application);
            Hashtable emp = e.read(Integer.parseInt(session.getAttribute("empId").toString()));
            if(session.getAttribute("msg") != null)
            {
                out.println("<script>swal('"+session.getAttribute("msg")+"','','success')</script>");
                session.removeAttribute("msg");
        }
        %>

                <div class="main-panel">
                    <div class="content-wrapper">

                        <div class="row">
                            <!-- Column -->
                            <div class="col-lg-4 col-xlg-3 col-md-5">
                                <div class="card" data-aos="fade-right">
                                    <div class="card-body" data-aos="fade-in">


                                        <center class="m-t-30"> 
                                            <%  String img = "empimages/" + emp.get("img");%>
                                            <div data-aos="zoom-in" style="background: url('<%= img%>');height:170px;background-size:85% 85%;width:170px;background-repeat:no-repeat;background-position:center center;"></div>
                                            <h4 class="card-title m-t-10" data-aos="zoom-out" ><%= emp.get("name")%></h4>
                                            <h6 class="card-subtitle" data-aos="zoom-out" ><%= emp.get("deptName")%></h6>
                                        </center>
                                    </div>
                                    <div class="card-body" data-aos="zoom-out" > 
                                        <small class="text-muted">Email address </small>
                                        <h6><%= emp.get("emailId")%></h6> 

                                        <small class="text-muted p-t-30 db">Phone</small>
                                        <h6>+91 <%= emp.get("mobileNo")%></h6> 

                                        
                                        <small class="text-muted p-t-30 db">DOB</small>
                                        <h6><%= new SimpleDateFormat("dd-MM-yyyy").format(emp.get("dob")) %></h6> 

                                        <small class="text-muted p-t-30 db">Gender</small>
                                        <h6><%= emp.get("gender")%></h6> 

                                        <small class="text-muted p-t-30 db">Address</small>
                                        <h6><%= emp.get("address")%></h6>

                                        <small class="text-muted p-t-30 db">Registration Date</small>
                                        <h6><%= new SimpleDateFormat("dd-MM-yyyy | HH:mm:ss").format(emp.get("regDate"))%></h6> 


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
                                    <div class="card-body" data-aos="zoom-in">
                                        <h4 class="card-title">Update Profile</h4>
                                        <form class="forms-sample" action="#" onsubmit="return valid()" enctype="multipart/form-data" method="post">
                                            <div class="form-group">
                                                <label for="name">Name</label>
                                                <input type="text" class="form-control" id="name" value="<%= emp.get("name")%>" name="name" placeholder="Enter Name" autofocus disabled>
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email address</label>
                                                <input type="email" class="form-control" id="email" value="<%= emp.get("emailId")%>" name="email" placeholder="Enter Email address">
                                            </div>

                                            <div class="form-group">
                                                <label for="mobno">Mobile NO.</label>
                                                <input type="text" disabled="" maxlength="10" class="form-control" placeholder="Enter Mobile No." value="<%= emp.get("mobileNo")%>" id="mobno" name="mobno">
                                            </div>


                                            <div class="form-group">
                                                <label for="dob">Date Of Birth</label>
                                                <input type="date" class="form-control" id="dob" name="dob" value="<%= emp.get("dob")%>">
                                            </div>

                                            <div class="form-group">
                                                <label for="gender">Gender</label>
                                                <select class="form-control" id="gender" name="gender">
                                                    <option value="" selected>Select Gender</option>
                                                    <option value="Male" <%= emp.get("gender").equals("Male") ? "selected" : ""%>>Male</option>
                                                    <option value="Female" <%= emp.get("gender").equals("Female") ? "selected" : ""%>>Female</option>
                                                </select>
                                            </div>


                                            <div class="form-group">
                                                <label for="deptId">Department</label>
                                                <select class="form-control form-select" id="deptId" name="deptId" disabled="">
                                                    <option value="" selected>Select Department</option>
                                                    <%
                                                        Vector v = d.readAllId();
                                                        for (int i = 0; i < v.size(); i++) {
                                                            Hashtable h = d.read((int) v.get(i));
                                                    %>
                                                    <option value="<%= h.get("deptId")%>" <%= emp.get("deptId").equals(h.get("deptId")) ? "selected" : ""%>><%= h.get("deptId")%> - <%= h.get("deptName")%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="pimg">Choose Profile Image</label>
                                                <input type="file" name="pimg" id="pimg" class="form-control">
                                                <input type="hidden" name="oldimg" value="<%= emp.get("img")%>">
                                            </div>

                                            <div class="form-group">
                                                <label for="address">Address</label>
                                                <textarea class="form-control" id="address" name="address" placeholder="Enter Address" rows="4"><%= emp.get("address")%></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="pass">Password</label>
                                                <input type="password" class="form-control" id="pass" value="<%= emp.get("password")%>" name="pass" placeholder="Enter Password">
                                            </div>

                                            <div class="form-group">
                                                <div class="form-check form-check-danger">
                                                    <label class="form-check-label">
                                                        <input type="checkbox" class="form-check-input" onchange="show()"> Show Password <i class="input-helper"></i></label>
                                                </div>    
                                            </div>


                                            <button type="submit" class="btn btn-success p-2 q mr-2" name="edit">Update</button>
                                            <button class="btn btn-warning p-2" type="reset">Clear</button>

                                        </form>
                                    </div>                                
                                </div>
                            </div>
                            <!-- Column -->
                        </div>
                        <%
            if (request.getParameter("edit") != null) {
                String ename = emp.get("name").toString();
                String email = request.getParameter("email");
                String mobno = emp.get("mobileNo").toString();
                String dob = request.getParameter("dob");
                String gender = request.getParameter("gender");
                String deptId = emp.get("deptId").toString();

                Part pimg = request.getPart("pimg");
                String pimgName = pimg.getSubmittedFileName();
                String loc = new File(application.getRealPath("/")).getParentFile().getParent() + File.separator + "web" + File.separator + "empimages";
                String oldimg = request.getParameter("oldimg");
                
                String address = request.getParameter("address");
                String pass = request.getParameter("pass");
//                out.println(ename + "<br>" + email + "<br>" + mobno + "<br>" + dob + "<br>" + gender + "<br>" + deptId + "<br>" + pimg.getSubmittedFileName() + "<br>" + address + "<br>" + pass);
                try {
                    int eid = Integer.parseInt(session.getAttribute("empId").toString());
                    if(e.isEmail(email) == 0 || e.isEmail(email) == eid)
                    {
                        int row;
                        if(pimgName == "")
                        {
                            row = e.update(eid, ename, email, Integer.parseInt(deptId), gender, dob, address, mobno, pass, oldimg);
                        }
                        else
                        {
                            row = e.update(eid, ename, email, Integer.parseInt(deptId), gender, dob, address, mobno, pass, pimgName);
                            if(row > 0)
                            {
                                pimg.write(loc + File.separator + pimgName);
                            }
                        }
                            if(row > 0)
                            {
                                session.setAttribute("msg","Profile Successfully Update");
                                out.println("<script>window.location.href='profile.jsp'</script>");
                            }

                    }
                    else
                    {
                        out.println("<script>swal('Your Given Email Address Already Available','','error')</script>");
                    }
                } catch (Exception e1) {
                    out.println(e1);
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
