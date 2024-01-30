<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="elms.*" %>
<%@page import="java.text.*" %>
<%@page  import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
      <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>
        <%! admin a; %>
        <% a = new admin(application); %>
        <%
            if(session.getAttribute("msg") != null)
            {
                out.println("<script>swal('"+session.getAttribute("msg")+"','','success')</script>");
                session.removeAttribute("msg");
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
           
              <div class="row" data-aos="fade-down">
                            <div class="col-12 grid-margin">
                                <button class="btn btn-outline-info btn-icon-text float-right" data-toggle="modal" data-target="#addmodal"><i class="fa-solid fa-plus btn-icon-prepend icon-large"></i> ADD ADMIN </button>                            
                            </div>
                        </div>

                        <div class="row" data-aos="fade-up">

                            <div class="col-lg-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body" data-aos="fade-in">
                                        <div class="row">
                                            <div class="col">
                                                <p>
                                                <h4 class="card-title" data-aos="zoom-in">All Admins</h4>
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
                                                        <th> AID </th>
                                                        <th> Admin Name</th>
                                                        <th> Email Address </th>
                                                        <th> Created Date </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Vector v = a.readAllId();
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            Hashtable h = a.read((int)v.get(i));
                                                            %>
                                                    <tr>
                                                        <td><%= h.get("id") %></td>
                                                        <td><%= h.get("name") %></td>
                                                        <td><%= h.get("emailId") %></td>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(h.get("createdAt")) %></td>
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
 
    <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Admin</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="addadmin" action="#" method="post" onsubmit="return addvalid()">
                            <div class="form-group">
                                <label for="addname" class="col-form-label">Admin Name</label>
                                <input type="text" class="form-control" id="addname" name="addname" placeholder="Enter Admin Name" >
                            </div>
                            <div class="form-group">
                                <label for="addemail" class="col-form-label">Email address</label>
                                <input type="email" class="form-control" id="addemail" name="addemail" placeholder="Enter Email address"></input>
                            </div>
                            <div class="form-group" style="position: relative;">
                                <label for="pass" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="pass" name="addpass" placeholder="Enter Password"></input>
                                <i type="button" class="btn btn-primary" id="passicon" onclick="chgpass()" style="position: absolute;right:4px;top:37px;padding:15px;"><i class="fa-solid fa-eye" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 15px;" ></i></i>

                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-success" value="adminadd" name="add">ADD</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
                        
              
              <%
                if(request.getParameter("add") != null)
                {
                    String aname = request.getParameter("addname");
                    String aemail = request.getParameter("addemail");
                    String apass = request.getParameter("addpass");
                    
//                    out.println(aname + "<br>" + aemail + "<br>" + apass);
                    if(a.isEmail(aemail) == 0)
                    {
                        int row = a.add(aname, aemail, apass);
                        if(row > 0)
                        {
                            session.setAttribute("msg", "New Admin Successfully Added");
                            out.println("<script>window.location.href='alladmin.jsp'</script>");
                        }                    
                    }
                    else
                   {
                        out.println("<script>swal('Your Given Email Id Already Registered','','error')</script>");
                    }
                }
                %>
                <script>
            function search(input)
            {
                table = document.getElementsByTagName("table")[0];
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++)
                {
                    aid = tr[i].getElementsByTagName("td")[0].innerText.toLowerCase();
                    aname = tr[i].getElementsByTagName("td")[1].innerText.toLowerCase();
                    aemail = tr[i].getElementsByTagName("td")[2].innerText.toLowerCase();
                    cdate = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    inputval = input.value.toLowerCase();
                    if (aid.match(inputval) || aname.match(inputval) || aemail.match(inputval) || cdate.match(inputval))
                    {
                        tr[i].style.display = "";
                    } else
                    {
                        tr[i].style.display = "none";
                    }

                }

            }

                    function addvalid()
                    {
                        aname = $("#addname");
                        aemail = $("#addemail");
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

