package elms;
import java.sql.*;
import java.util.*;
import javax.servlet.*;

public class leavetype {
    Connection con;
    public leavetype(ServletContext application) throws Exception
    {
        String url,un,pass;
        url = application.getInitParameter("url");
        un = application.getInitParameter("username");
        pass = application.getInitParameter("password");
        String  driverClass = application.getInitParameter("driverClass");
        Class.forName(driverClass);
        con = DriverManager.getConnection(url,un,pass);
    }
    public Hashtable read(int ltypeId) throws SQLException
    {
        Hashtable h = new Hashtable();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from leavetypes where leaveTypeId = '"+ltypeId+"'");
        if(rs.next())
        {
            h.put("leaveTypeId",rs.getObject("leaveTypeId"));
            h.put("leaveType",rs.getObject("leaveType"));
            h.put("description",rs.getObject("description"));
            h.put("createdAt",rs.getObject("createdAt"));
        }
        rs.close();
        stmt.close();
        return h;
    }
    public Vector readAllId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from leavetypes");
        while(rs.next())
        {
            v.add(rs.getObject("leaveTypeId"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    public int add(String leaveType,String description) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("insert into leavetypes(leaveType,description) values(?,?)");
        pstmt.setObject(1,leaveType);
        pstmt.setObject(2,description);
        return pstmt.executeUpdate();
    }    

    public int update(int ltypeId,String leaveType,String description) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update leaveTypes set leaveType = ?,description = ? where leaveTypeId = ?");
        pstmt.setObject(1,leaveType);
        pstmt.setObject(2,description);
        pstmt.setObject(3,ltypeId);
        return pstmt.executeUpdate();
    }
    public int delete(int ltypeId) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("delete from leavetypes where leaveTypeId = ?");
        pstmt.setObject(1, ltypeId);
        return pstmt.executeUpdate();
    }
}
