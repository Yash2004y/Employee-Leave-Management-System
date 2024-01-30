package elms;
import java.sql.*;
import javax.servlet.*;
import java.util.*;



public class department {
Connection con;
    public department(ServletContext application) throws Exception
    {
        String url,un,pass;
        url = application.getInitParameter("url");
        un = application.getInitParameter("username");
        pass = application.getInitParameter("password");
        String  driverClass = application.getInitParameter("driverClass");
        Class.forName(driverClass);
        con = DriverManager.getConnection(url,un,pass);
    }
    public Hashtable read(int deptId) throws SQLException
    {
        Hashtable h = new Hashtable();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from departments where deptId = '"+deptId+"'");
        if(rs.next())
        {
            h.put("deptId",rs.getObject("deptId"));
            h.put("deptName",rs.getObject("deptName"));
            h.put("deptShortName",rs.getObject("deptShortName"));
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
        ResultSet rs = stmt.executeQuery("select * from departments");
        while(rs.next())
        {
            v.add(rs.getObject("deptId"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    public int add(String deptName,String deptShortName) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("insert into departments(deptName,deptShortName) values(?,?)");
        pstmt.setObject(1,deptName);
        pstmt.setObject(2,deptShortName);
        return pstmt.executeUpdate();
    }    

    public int update(int deptId,String deptName,String deptShortName) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update departments set deptName = ?,deptShortName = ? where deptId = ?");
        pstmt.setObject(1,deptName);
        pstmt.setObject(2,deptShortName);
        pstmt.setObject(3,deptId);
        return pstmt.executeUpdate();
    }
    public int delete(int deptId) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("delete from departments where deptId = ?");
        pstmt.setObject(1, deptId);
        return pstmt.executeUpdate();
    }   
}
