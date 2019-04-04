package com.hms.dao;

import com.hms.model.warehouse.FactWarehouse;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

@Service
public class WareHouseDao {


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
            String sql = "Select top 1 * from date_dimension;";
            ResultSet resultSet = stmt.executeQuery(sql);
            while(resultSet.next()) {
                System.out.println("result set" );
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("error connecting to warehouse");
        }
    }

}
