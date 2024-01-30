package elms;
import java.util.*;
import java.sql.*;
import javax.servlet.*;

public class leave {
     Connection con;
    
    public leave(ServletContext application) throws Exception
    {
        String url,un,pass,driverClass;
        url = application.getInitParameter("url");
        un = application.getInitParameter("username");
        pass = application.getInitParameter("password");
        driverClass = application.getInitParameter("driverClass");
        Class.forName(driverClass);
        con = DriverManager.getConnection(url,un,pass);
    }
    
    public Hashtable read(int leaveId) throws SQLException
    {
        Hashtable h = new Hashtable();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where l.id = '"+leaveId+"' and l.eid = e.eid");
        if(rs.next())
        {
            h.put("id",rs.getObject("id"));
            h.put("leaveTypeId",rs.getObject("leaveTypeId"));
            h.put("toDate",rs.getObject("toDate"));
            h.put("fromDate",rs.getObject("fromDate"));
            h.put("description",rs.getObject("description"));
            h.put("postingDate",rs.getObject("postingDate"));
            h.put("adminRemark",rs.getObject("adminRemark") == null ?  "" : rs.getObject("adminRemark"));
            h.put("adminRemarkDate",rs.getObject("adminRemarkDate") == null ?  "" : rs.getObject("adminRemarkDate"));
            h.put("status",rs.getObject("status"));
            h.put("isRead",rs.getObject("isRead"));
            h.put("eid",rs.getObject("eid"));
        
        }
        rs.close();
        stmt.close();
        return h;
    }
    
    public Vector readAllEmpLeaveId(int eid) throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where e.eid = l.eid and l.eid = '"+eid+"'");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    
    public Vector readAllId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where e.eid = l.eid");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    
    public Vector readAllPendingId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where l.status = '1' and e.eid = l.eid");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }
    public Vector readAllUnreadId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where l.isRead = '0' and e.eid = l.eid");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }

    
    public Vector readAllApprovedId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where l.status = '2' and e.eid = l.eid");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }

    public Vector readAllRejectedId() throws SQLException
    {
        Vector v = new Vector();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select l.* from leaves l,employees e where l.status = '0' and e.eid = l.eid");
        while(rs.next())
        {
            v.add(rs.getObject("id"));
        }
        rs.close();
        stmt.close();
        return v;
    }

    public int add(int eid,int leaveTypeId,String fromDate,String toDate,String description) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("insert into leaves(eid,leaveTypeId,fromDate,toDate,description) values(?,?,?,?,?)");
        pstmt.setObject(1,eid);
        pstmt.setObject(2,leaveTypeId);
        pstmt.setObject(3,fromDate);
        pstmt.setObject(4,toDate);
        pstmt.setObject(5,description);
        return pstmt.executeUpdate();
    }    

    public int update(int leaveId,int eid,int leaveTypeId,String fromDate,String toDate,String description) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update leaves set eid = ?,leaveTypeId = ?,fromDate = ?,toDate = ?,description = ?,status = ?,isRead = ? where id = ?");
        pstmt.setObject(1,eid);
        pstmt.setObject(2,leaveTypeId);
        pstmt.setObject(3,fromDate);
        pstmt.setObject(4,toDate);
        pstmt.setObject(5,description);
        pstmt.setObject(6,1);
        pstmt.setObject(7,0);
        pstmt.setObject(8,leaveId);
        return pstmt.executeUpdate();
    }
    public void updateRead(int leaveId) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update leaves set isRead = 1 where id = ?");
        pstmt.setObject(1,leaveId);
        pstmt.executeUpdate();
    }
    public int updateStatus(int leaveId,int status,String aremark,String date) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("update leaves set status = ? , adminRemark = ? , adminRemarkDate = ? where id = ?");
        pstmt.setObject(1,status);
        pstmt.setObject(2,aremark);
        pstmt.setObject(3,date);
        pstmt.setObject(4,leaveId);
        return pstmt.executeUpdate();
    }
    public int delete(int leaveId) throws SQLException
    {
        PreparedStatement pstmt = con.prepareStatement("delete from leaves where id = ?");
        pstmt.setObject(1, leaveId);
        return pstmt.executeUpdate();
    }   
}
