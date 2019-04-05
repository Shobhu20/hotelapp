package com.hms.dao;

import com.hms.model.warehouse.FactWarehouse;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WareHouseDao {

    private static SQLServerDataSource ds;
    static {
        ds = new SQLServerDataSource();
        ds.setUser("jalaj");
        ds.setPassword("jalajkhanna");
        ds.setServerName("hoteldbjalaj.ch3hqwgdbwn9.us-east-2.rds.amazonaws.com");
        ds.setPortNumber(1433);
        ds.setDatabaseName("hoteldwh");
    }

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    public void insertIntoWareHouse(List<FactWarehouse> factWarehouses) {
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


    /*
*
 * --query to find total amount earned by each locations in a month/year
--select sum(f.amount),l.loc_city from facttable f, location_dimension l, date_dimension d
where f.loc_id = l.loc_id and f.datekey = d.datekey and
d.monthname = 'March' and d.year = 2019 group by l.loc_city
*/
    public Map findAmountForMonthEachLocation(String month, String year) {
        Map<String, String> resultMap = new HashMap<>();
        String sql = "select sum(f.amount) as tot_amtt,l.loc_city from facttable f, location_dimension l, date_dimension d " +
                "where f.loc_id = l.loc_id and f.datekey = d.datekey and d.monthname = " +
                getQuotedString(month) + " and d.year = " + year + " group by l.loc_city";
        try {
            Connection conn  = ds.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String amount = rs.getString("tot_amtt");
                String locCity = rs.getString("loc_city");
                resultMap.put(locCity, amount);
            }
            stmt.close();
            conn.close();
            return resultMap;
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
        return null;
    }

    private String getQuotedString(String str1) {
        return "'" + str1 + "'";
    }


    /*--query to find sum of amount earned by customers who are NOT from the country of hotel
--select sum(f.amount) ,c.cust_nationality from facttable f , customer_dimension c
where f.cust_id = c.cust_id and
c.cust_nationality != 'mexico' and c.cust_nationality != 'nigeria' group by c.cust_nationality*/
    public Map findAmountEarnedByEachForeignerCountry() {
        Map<String, String> resultMap = new HashMap<>();
        String sql ="select sum(f.amount) as tot_amttt ,c.cust_nationality from facttable f , customer_dimension c where f.cust_id = c.cust_id and" +
                " c.cust_nationality != 'mexico' and c.cust_nationality != 'nigeria' group by c.cust_nationality";
        try {
            Connection conn  = ds.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String amount = rs.getString("tot_amtt");
                String nationality = rs.getString("cust_nationality");
                resultMap.put(nationality, amount);
            }
            stmt.close();
            conn.close();
            return resultMap;
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
        return null;
    }

    /*--number of days of booking greater than x
select sum(f.amount) as sum_amt,count(f.booking_id) as booking_count , datediff(day,b.from_date,b.to_date) NumberOfDays from facttable f, booking_dimension b
where  f.booking_id = b.booking_id and  datediff(day,b.from_date,b.to_date) > 1 group by datediff(day,b.from_date,b.to_date)
*/
    public Map numOfBookingsWithBookingGreaterThanXDays(Integer x) {
        Map<String, Map<String , String>> resultMap = new HashMap<>();
        String sql ="select sum(f.amount) as sum_amt,count(f.booking_id) as booking_count , datediff(day,b.from_date,b.to_date) as num_of_days from facttable f, booking_dimension b" +
                " where  f.booking_id = b.booking_id and  datediff(day,b.from_date,b.to_date) > " + x +
                "group by datediff(day,b.from_date,b.to_date)";
        try {
            Connection conn  = ds.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String amount = rs.getString("sum_amt");
                String bookingCount = rs.getString("booking_count");
                String numOfDays = rs.getString("num_of_days");
                Map<String, String > hm = new HashMap<>();
                hm.put(bookingCount, amount);
                resultMap.put(numOfDays, hm);
            }
            stmt.close();
            conn.close();
            return resultMap;
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
        return null;
    }


    /*
    * --total amount earned by all locations in a month/year
--select sum(f.amount) from facttable f, date_dimension d where f.datekey = d.datekey
    and d.monthname = 'March' and d.year = 2019 */
    public Integer findTotalAmountEarnedByAllLocation(String month, String year) {
        String sql ="select sum(f.amount) as tot_amt from facttable f, date_dimension d where f.datekey = d.datekey and d.monthname = " +
                getQuotedString(month) + " and d.year = " + year;
        try {
            Connection conn  = ds.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            Integer totAmt = 0;
            while (rs.next()) {
                totAmt = rs.getInt("tot_amt");
            }
            stmt.close();
            conn.close();
            return totAmt;
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
        return null;
    }

    /*
    * --find max amount through a single booking in a given year/month/location/customer whatever. used year in this case

--select max(amount)  from facttable f, date_dimension d,customer_dimension c where   f.datekey = d.datekey and  d.year = 2019*/

    public Integer findMaxBookingAmountForMonth(String month) {
        String sql ="select max(amount) as max_amount from facttable f, date_dimension d,customer_dimension c where   f.datekey = d.datekey and  d.monthname =" +
                 getQuotedString(month);
        try {
            Connection conn  = ds.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            Integer totAmt = 0;
            while (rs.next()) {
                totAmt = rs.getInt("max_amount");
            }
            stmt.close();
            conn.close();
            return totAmt;
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
        return null;
    }



}
