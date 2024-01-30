<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>

      <%@include file="partials/headerfile.jsp" %>

  </head>
  <body>
      <%! String email,pass; %>
      <%
            if(request.getParameter("login") != null)
            {
                email = request.getParameter("email");
                pass = request.getParameter("pass");
            }
        %>
    <div class="container-scroller">
      <div class="container-fluid page-body-wrapper full-page-wrapper">
        <div class="row w-100 m-0">
          <div class="content-wrapper full-page-wrapper d-flex align-items-center auth login-bg">
            <div class="card col-lg-4 mx-auto" data-aos="zoom-out">
              <div class="card-body px-5 py-5">
                <h3 class="card-title text-left mb-3">Admin Login</h3>
                <form action="#" method="post" data-aos="zoom-in" data-aos-duration="1000">
                  <div class="form-group">
                    <label>Email Addresss *</label>
                    <input type="text" class="form-control p_input" name="email" id="email" placeholder="Enter Email address" autofocus>
                  </div>
                    <div class="form-group mb-4" style="position:relative;">
                    <label>Password *</label>
                    <input type="password" name="pass" style="padding-right: 40px;" class="form-control" id="pass" name="addpass" placeholder="Enter Password"></input>
                    <i class="btn btn-primary" id="passicon" onclick="chgpass()" style="position: absolute;right:4px;top:27px;padding:15px;"><i class="fa-solid fa-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 15px;" ></i></i>

                  </div>
                  <div class="text-center">
                    <button name="login" type="submit" class="btn btn-warning btn-block enter-btn">Login</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <!-- content-wrapper ends -->
        </div>
        <!-- row ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <%
        if(request.getParameter("login") != null)
        {

//            out.println(email + "<br>" + pass);
            admin a = new admin(application);
            int adminId = a.isEmail(email);
            if(adminId != 0)
            {
                Hashtable h = a.read(adminId);
                if(h.get("pass").equals(pass))
                {
                    session.setAttribute("adminId", adminId);
                    out.println("<script>window.location.href='index.jsp'</script>");
                }
                else
                {
                    out.println("<script>swal('Password is wrong','','error')</script>");
                }
            }
            else
            {
                out.println("<script>swal('Your Email Address Not Registered','','error')</script>");
            }
        }
        %>
          <%@include file="partials/scriptfile.jsp" %>
    
  </body>
</html>