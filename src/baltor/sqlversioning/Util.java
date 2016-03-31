package baltor.sqlversioning;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLTimeoutException;
import java.sql.Statement;

public class Util {

	public static void patchItemNames() {
		
		Connection c = null;
		
		try {
			Class.forName("org.sqlite.JDBC");
			c = DriverManager.getConnection("jdbc:sqlite:assets/itempatch.db");
			c.setAutoCommit(false);
			System.out.println("Opened database successfully");
			
			queryDatabase(c, "SELECT item_id, patched_name FROM patched_names_type1;");

			c.close();
		} catch (SQLTimeoutException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static void queryDatabase(Connection c, String query) {
		try {
			Statement stmt = null;
		    
			stmt = c.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int itemID = rs.getInt("item_id");
				String patchedName = rs.getString("patched_name");
				System.out.println("item_name[" + itemID + "] = \"" + patchedName + "\";");
			}

			rs.close();
			stmt.close();
			
		} catch (SQLException e) {
			System.err.println("Error patching item names from database values.");
			e.printStackTrace();
		}
	}
}