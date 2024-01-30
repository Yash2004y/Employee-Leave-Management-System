
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
           
              <%--code--%>
            
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
