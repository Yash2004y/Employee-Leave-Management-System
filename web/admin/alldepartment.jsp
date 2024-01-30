
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
        <div class="container-scroller">
            <!-- partial:partials/_sidebar.jsp -->
          <jsp:include page="partials/_sidebar.jsp" />

            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <!-- partial:partials/_navbar.jsp -->    
                <jsp:include page="partials/_navbar.jsp" />

                <!-- partial -->
                <%! department d;%>
                <% try {
                        d = new department(application);
                    } catch (Exception e) {
                        out.println(e);
                    }
                    if (session.getAttribute("msg") != null) {
                        out.println("<script>swal('" + session.getAttribute("msg") + "','','success')</script>");
                        session.removeAttribute("msg");
                    }
                %>
                <div class="main-panel">
                    <div class="content-wrapper">

                        <div class="row" data-aos="fade-down">
                            <div class="col-12 grid-margin">
                                <button class="btn btn-outline-warning btn-icon-text float-right" data-toggle="modal" data-target="#add"><i class="fa-solid fa-plus btn-icon-prepend icon-large"></i> ADD DEPARTMENT </button>                            
                            </div>
                        </div>

                        <div class="row" data-aos="fade-up">

                            <div class="col-lg-12 grid-margin stretch-card">
                                <div class="card">
                                    <div class="card-body" data-aos="fade-in">
                                        <div class="row">
                                            <div class="col">
                                                <p>
                                                <h4 class="card-title" data-aos="zoom-in">All Departments</h4>
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
                                                        <th> Department Name</th>
                                                        <th> Department Short Name </th>
                                                        <th> Created Date </th>
                                                        <th> Action </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        Vector v = d.readAllId();
                                                        for (int i = 0; i < v.size(); i++) {
                                                            Hashtable h = d.read((int) v.get(i));
                                                            SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                            String createdAt = new SimpleDateFormat("dd-MM-yyyy").format(f1.parse(h.get("createdAt").toString()));
                                                    %>
                                                    <tr>
                                                        <td class="py-1"><%= h.get("deptId")%></td>
                                                        <td> <%= h.get("deptName")%> </td>
                                                        <td><%= h.get("deptShortName")%></td>
                                                        <td><%= createdAt%></td>
                                                        <td> 
                                                            <button class="btn btn-warning" style="position: relative;padding:15px;" onclick="disp(this)" data-toggle="modal" data-target="#editmodal" deptName="<%= h.get("deptName")%>" deptShortName="<%= h.get("deptShortName")%>" deptId="<%= h.get("deptId")%>">
                                                                <i class="mdi mdi-lead-pencil" style="position: absolute;top:50%;left: 50%;transform: translate(-50%,-50%);font-size: 20px;"></i>
                                                            </button>
                                                            <button class="btn btn-danger" style="position: relative;padding:15px;" onclick="deletemodal(this)" data-toggle="modal" data-target="#deletemodal" deptId="<%= h.get("deptId")%>" deptName="<%= h.get("deptName")%>" deptShortName="<%= h.get("deptShortName")%>">
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
                    <!-- content-wrapper ends -->

                    <!-- partial:partials/_footer.jsp -->
                    <%@include file="partials/_footer.jsp" %>
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>


        <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Department</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="adddept" action="#" method="post" onsubmit="return addvalid()">
                            <div class="form-group">
                                <label for="dname" class="col-form-label">Department Name</label>
                                <input type="text" class="form-control" id="dname" name="dname" >
                            </div>
                            <div class="form-group">
                                <label for="dsname" class="col-form-label">Department Short Name</label>
                                <input type="text" class="form-control" id="dsname" name="dsname">
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="deptadd" name="add">ADD</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            if (request.getParameter("add") != null) {
                String dname = request.getParameter("dname");
                String dsname = request.getParameter("dsname");
                try {
                    int row = d.add(dname, dsname);
                    if (row > 0) {
                        session.setAttribute("msg", "Successfully Department Added");
                        out.println("<script>window.location.href='alldepartment.jsp'</script>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }

            }
        %>

        <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit Department</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="editdept" action="#" method="post" onsubmit="return editvalid()">
                            <div class="form-group">
                                <label for="editdname" class="col-form-label">Department Name</label>
                                <input type="text" class="form-control" id="editdname" name="editdname" autofocus >
                            </div>
                            <input type="hidden" id="editdeptId" name="editdeptId" value=""/>
                            <div class="form-group">
                                <label for="editdsname" class="col-form-label">Department Short Name</label>
                                <input type="text" class="form-control" id="editdsname" name="editdsname">
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" value="deptedit" name="edit">Update</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            if (request.getParameter("edit") != null) {
                String dname = request.getParameter("editdname");
                String dsname = request.getParameter("editdsname");
                String deptId = request.getParameter("editdeptId");
                try {
                    int row = d.update(Integer.parseInt(deptId), dname, dsname);
                    if (row > 0) {
                        session.setAttribute("msg", "Successfully Department Updated");
                        out.println("<script>window.location.href='alldepartment.jsp'</script>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }

            }
        %>
        <script>
            function disp(btn)
            {
                deptId = btn.getAttribute("deptId");
                deptName = btn.getAttribute("deptName");
                deptShortName = btn.getAttribute("deptShortName");
                $("#editdname").val(deptName);
                $("#editdsname").val(deptShortName);
                $("#editdeptId").val(deptId);
            }
        </script>
        <div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Are You Sure Delete Department ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form name="deletedept" action="#" method="post">
                            <div class="form-group">
                                <label for="deletedname" class="col-form-label">Department Name</label>
                                <input type="text" class="form-control text-dark" id="deletedname" name="deletedname" autofocus disabled>
                            </div>
                            <input type="hidden" id="deletedeptId" name="deletedeptId" value=""/>
                            <div class="form-group">
                                <label for="deletedsname" class="col-form-label">Department Short Name</label>
                                <input type="text" class="form-control text-dark" id="deletedsname" name="deletedsname" disabled>
                            </div>
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
            if (request.getParameter("delete") != null) {
                String dname = request.getParameter("deletedname");
                String dsname = request.getParameter("deletedsname");
                String deptId = request.getParameter("deletedeptId");
                try {
                    int row = d.delete(Integer.parseInt(deptId));
                    if (row > 0) {
                        session.setAttribute("msg", "Successfully Department Deleted");
                        out.println("<script>window.location.href='alldepartment.jsp'</script>");
                    }
                } catch (Exception e) {
                    out.println(e);
                }

            }
        %>
        <script>
            function deletemodal(btn)
            {
                deptId = btn.getAttribute("deptId");
                deptName = btn.getAttribute("deptName");
                deptShortName = btn.getAttribute("deptShortName");
                $("#deletedname").val(deptName);
                $("#deletedsname").val(deptShortName);
                $("#deletedeptId").val(deptId);
            }
            function search(input)
            {
                table = document.getElementsByTagName("table")[0];
                tr = table.getElementsByTagName("tr");
                for (i = 1; i < tr.length; i++)
                {
                    did = tr[i].getElementsByTagName("td")[0].innerText.toLowerCase();
                    dname = tr[i].getElementsByTagName("td")[1].innerText.toLowerCase();
                    dsname = tr[i].getElementsByTagName("td")[2].innerText.toLowerCase();
                    cdate = tr[i].getElementsByTagName("td")[3].innerText.toLowerCase();
                    inputval = input.value.toLowerCase();
                    if (did.match(inputval) || dname.match(inputval) || dsname.match(inputval) || cdate.match(inputval))
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
                dname = $("#dname");
                dsname = $("#dsname");
                if(dname.val().trim() == "")
                {
                    return swalalert("Please Enter Department Name","","error",dname);
                }
                else if(dname.val().trim().match("[0-9]"))
                {
                    return swalalert("Number Not Allow In Department Name","","error",dname);
                }
                else if(dsname.val().trim() == "")
                {
                    return swalalert("Please Enter Department Short Name","","error",dsname);
                }
                else if(dsname.val().trim().match("[0-9]"))
                {
                    return swalalert("Number Not Allow In Department Short Name","","error",dsname);
                }
                else
                {
                    return true;
                }
            }
             function editvalid()
            {
                dname = $("#editdname");
                dsname = $("#editdsname");
                if(dname.val().trim() == "")
                {
                    return swalalert("Please Enter Department Name","","error",dname);
                }
                else if(dname.val().trim().match("[0-9]"))
                {
                    return swalalert("Number Not Allow In Department Name","","error",dname);
                }
                else if(dsname.val().trim() == "")
                {
                    return swalalert("Please Enter Department Short Name","","error",dsname);
                }
                else if(dsname.val().trim().match("[0-9]"))
                {
                    return swalalert("Number Not Allow In Department Short Name","","error",dsname);
                }
                else
                {
                    return true;
                }
            }
        </script>
        <%@include file="partials/scriptfile.jsp" %>
    </body>
</html>
