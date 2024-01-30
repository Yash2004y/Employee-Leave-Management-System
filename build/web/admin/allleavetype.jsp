<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="elms.*" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="partials/headerfile.jsp" %>
    </head>
    <body>
        <%! leavetype l; %>
        <%
            l = new leavetype(application);
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
                                <button class="btn btn-outline-success btn-icon-text float-right" data-toggle="modal" data-target="#addmodal"><i class="fa-solid fa-plus btn-icon-prepend icon-large"></i> ADD LEAVE TYPE </button>                            
                            </div>
                        </div>

                        <div class="row" data-aos="fade-up">

                            <div class="col-lg-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body">

                                        <div class="row">
                                            <div class="col">
                                                <p>
                                                <h4 class="card-title" data-aos="zoom-in">All Leave Types</h4>
                                                </p>        
                                            </div>
                                            <div class="col">
                                                <input type="text" data-aos="zoom-in" id="search" placeholder="Search" class="form-control text-secondary" onkeyup="search(this)" onkeydown="search(this)" onkeypress="search(this)">
                                            </div>

                                        </div>


                                        <div class="table-responsive">
                                            <table class="table table-striped text-center" data-aos="zoom-in" data-aos-offset="100">
                                                <thead>
                                                    <tr>
                                                        <th> LID </th>
                                                        <th> Leave Type </th>
                                                        <th> Description </th>
                                                        <th> Creation Date </th>
                                                        <th> Action </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Vector lid = l.readAllId();
                                                        for(int i = 0;i<lid.size();i++)
                                                        {
                                                            Hashtable leave = l.read((int)lid.get(i));
                                                        %>
                                                        
                                                        <tr>
                                                            <td> <%= leave.get("leaveTypeId") %> </td>
                                                        <td> <%= leave.get("leaveType") %> </td>
                                                        <td> <%= leave.get("description") %> </td>
                                                        <td> <%= new SimpleDateFormat("dd-MM-yyyy").format(leave.get("createdAt")) %> </td>
                                                        <td>
                                                            <button class="btn btn-warning" style="position: relative;padding:15px;" onclick="editmodal(this)" data-toggle="modal" data-target="#editmodal" ltypeid="<%= leave.get("leaveTypeId") %>" ltype="<%= leave.get("leaveType") %>" ldesc="<%= leave.get("description") %>">
                                                                <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </button>
                                                            <button class="btn btn-danger" style="position: relative;padding:15px;" onclick="deletemodal(this)" data-toggle="modal" data-target="#deletemodal" ltypeid="<%= leave.get("leaveTypeId") %>" ltype="<%= leave.get("leaveType") %>" ldesc="<%= leave.get("description") %>">
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
                        
    <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Leave Type</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="addlt" action="#" method="post" onsubmit="return addvalid()">
                            <div class="form-group">
                                <label for="ltype" class="col-form-label">Leave Type</label>
                                <input type="text" class="form-control" id="ltype" name="ltype" placeholder="Enter Leave Type" >
                            </div>
                            <div class="form-group">
                                <label for="ldesc" class="col-form-label">Leave Description</label>
                                <textarea class="form-control" id="ldesc" rows="4" name="ldesc" placeholder="Enter Leave Description"></textarea>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="ltypeadd" name="add">ADD</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
                        
        <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Leave Type</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="editlt" action="#" method="post" onsubmit="return editvalid()">
                            <div class="form-group">
                                <label for="editltype" class="col-form-label">Leave Type</label>
                                <input type="text" class="form-control" id="editltype" name="editltype" placeholder="Enter Leave Type" >
                            </div>
                            <input type="hidden" name="editlid" id="editlid">
                            <div class="form-group">
                                <label for="editldesc" class="col-form-label">Leave Description</label>
                                <textarea class="form-control" id="editldesc" rows="4" name="editldesc" placeholder="Enter Leave Description"></textarea>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="ltypeedit" name="edit">Update</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
                        
                            
                <div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Are You Sure Delete This Leave Type ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="deletelt" action="#" method="post">
                            <div class="form-group">
                                <label for="deleteltype" class="col-form-label">Leave Type</label>
                                <input type="text" class="form-control text-dark" id="deleteltype" name="deleteltype" placeholder="Enter Leave Type" disabled>
                            </div>
                            <input type="hidden" name="deletelid" id="deletelid">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="ltypedelete" name="delete">Delete</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
                        <script>
                            function editmodal(btn)
                            {
                                ltypeid = btn.getAttribute("ltypeid");
                                ltype = btn.getAttribute("ltype");
                                ldesc = btn.getAttribute("ldesc");
//                                alert(ltypeid + " " + ltype + " " + ldesc);
                                $("#editltype").val(ltype);
                                $("#editlid").val(ltypeid);
                                $("#editldesc").val(ldesc);
                            }
                             function deletemodal(btn)
                            {
                                ltypeid = btn.getAttribute("ltypeid");
                                ltype = btn.getAttribute("ltype");
//                                alert(ltypeid + " " + ltype + " " + ldesc);
                                $("#deleteltype").val(ltype);
                                $("#deletelid").val(ltypeid);
                            }
                        </script>
                        <%
                            if(request.getParameter("add") != null)
                            {
                                String ltype = request.getParameter("ltype");
                                String ldesc = request.getParameter("ldesc");
                                int row = l.add(ltype, ldesc);
                                if(row > 0)
                                {
                                    session.setAttribute("msg", "Leave Type Successfully Added");
                                    out.println("<script>window.location.href='allleavetype.jsp'</script>");
                                }
                            }
                            if(request.getParameter("edit") != null)
                            {
                                String ltype = request.getParameter("editltype");
                                String ldesc = request.getParameter("editldesc");   
                                String ltypeid = request.getParameter("editlid");
//                                out.println(ltypeid + "<br>" + ltype + "<br>" + ldesc);
                                int row = l.update(Integer.parseInt(ltypeid), ltype, ldesc);
                                if(row > 0)
                                {
                                    session.setAttribute("msg", "Leave Type Successfully Updated");
                                    out.println("<script>window.location.href='allleavetype.jsp'</script>");
                                }
                            }
                            if(request.getParameter("delete") != null)
                            {
                                int ltypeid = Integer.parseInt(request.getParameter("deletelid"));
//                                out.println(ltypeid);
                                int row = l.delete(ltypeid);
                                if(row > 0)
                                {
                                    session.setAttribute("msg", "Leave Type Successfully Deleted");
                                    out.println("<script>window.location.href='allleavetype.jsp'</script>");
                                }
                            }                            
                         %>
                    </div>
                    <script>
                        function addvalid()
                        {
                            ltype = $("#ltype");
                            ldesc = $("#ldesc");
                            if(ltype.val().trim() == "")
                            {
                                return swalalert("Please Enter Leave Type","","error",ltype);
                            }
                            else if(ldesc.val().trim() == "")
                            {
                                return swalalert("Please Enter Leave Description","","error",ldesc);
                            }
                            else
                            {
                                return true;
                            }
                        }
                        function editvalid()
                        {
                            ltype = $("#editltype");
                            ldesc = $("#editldesc");
                            if(ltype.val().trim() == "")
                            {
                                return swalalert("Please Enter Leave Type","","error",ltype);
                            }
                            else if(ldesc.val().trim() == "")
                            {
                                return swalalert("Please Enter Leave Description","","error",ldesc);
                            }
                            else
                            {
                                return true;
                            }
                        }
            function search(input)
            {
                table = document.getElementsByTagName("table")[0];
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++)
                {
                    lid = tr[i].getElementsByTagName("td")[0].innerText.toLowerCase();
                    ltype = tr[i].getElementsByTagName("td")[1].innerText.toLowerCase();
                    ldesc = tr[i].getElementsByTagName("td")[2].innerText.toLowerCase();
                    cdate = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    inputval = input.value.toLowerCase();
                    if (lid.match(inputval) || ltype.match(inputval) || ldesc.match(inputval) || cdate.match(inputval))
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
