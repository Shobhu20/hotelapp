package com.hms.dao;

import com.hms.model.warehouse.FactWarehouse;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.List;

@Service
public class WareHouseDao {


    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public void insertIntoWareHouse(List<FactWarehouse> factWarehouses) {
        SQLServerDataSource ds = new SQLServerDataSource();
        ds.setUser("jalaj");
        ds.setPassword("jalajkhanna");
        ds.setServerName("hoteldbjalaj.ch3hqwgdbwn9.us-east-2.rds.amazonaws.com");
        ds.setPortNumber(1433);
        ds.setDatabaseName("hoteldwh");

        try {
            Connection conn = ds.getConnection();
            Statement stmt = conn.createStatement();
            for(FactWarehouse fw : factWarehouses) {
                int customerId = fw.getCustomer().getCustId();
                String sql = "select  * from Customer_Dimension where cust_id=" + customerId;
                ResultSet resultSet = stmt.executeQuery(sql);
                //if customer already exists in warehouse....do nothing
                if(!resultSet.next()) {
                    //insert into Customer_Dimension (cust_id,cust_name,cust_nationality) values (1,'Steve','Australia')
                    sql = "INSERT INTO Customer_Dimension (cust_id, cust_name, cust_nationality) VALUES (" + customerId +
                            ","  + getQuotedString(fw.getCustomer().getName()) + ","
                            + getQuotedString(fw.getCustomer().getNationality()) +")";
                    stmt.executeUpdate(sql);
                }
                //-insert into booking_dimension  (booking_id,from_date,to_date,people) values (1,'2018-01-01','2018-01-02',1)
                sql = "INSERT INTO booking_dimension  (booking_id,from_date,to_date,people) VALUES  (" +
                        fw.getBooking().getBookingId() + ","
                        + getQuotedString(sdf.format(fw.getBooking().getFromDate())) +
                        ","+ getQuotedString(sdf.format(fw.getBooking().getToDate())) +
                        ","+ fw.getBooking().getNumOfPeople() +")";
                stmt.executeUpdate(sql);

                //--insert into facttable (booking_id,cust_id,loc_id,datekey,amount) values (1,1,1,20180101,500)
                sql = "INSERT INTO facttable (booking_id,cust_id,loc_id,datekey,amount) VALUES (" +
                         fw.getBooking().getBookingId() + "," + fw.getCustomer().getCustId()
                        +"," + fw.getLocation().getLocationId() + "," + fw.getTimew().getId()
                        + "," + fw.getTotalAmount() + ")" ;
                stmt.executeUpdate(sql);
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
    }
    private String getQuotedString(String str1) {
        return "'" + str1 + "'";
    }
}
