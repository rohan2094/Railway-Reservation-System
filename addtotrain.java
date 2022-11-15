import java.io.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class addtotrain {
    public static void main(String args[]) {

        // JDBC

        Connection connection = null;

        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/db", "postgres", "1234");
            if (connection != null) {
                System.out.println("connection OK");
            } else {
                System.out.println("connection FAILED");
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        try {
            File file = new File("Trainschedule.txt"); // creates a new file instance
            FileReader fr = new FileReader(file); // reads the file
            BufferedReader br = new BufferedReader(fr); // creates a buffering character input stream
            //StringBuffer sb = new StringBuffer(); // constructs a string buffer with no characters
            String line;
            while ((line = br.readLine()) != "#") {

                // System.out.print(line);
                // System.out.print("\n");
                String[] lyn = line.split("\\s+");
                // for(int i=0;i<4;i++)
                // {
                //     System.out.print(lyn[i]);
                //     System.out.println("\n");
                // }
                if(lyn.length==1) break;
                try {

                    PreparedStatement stmt = connection.prepareStatement("call add_train(?,?,?,?)");
                    stmt.setInt(1, Integer.parseInt(lyn[0]));
                    stmt.setString(2, lyn[1]);
                    stmt.setInt(3, Integer.parseInt(lyn[2]));
                    stmt.setInt(4, Integer.parseInt(lyn[3]));
                    stmt.execute();
                    stmt.close();

                } catch (Exception err) {
                    // System.out.println("An error has occurred.");
                    // System.out.println("See full details below.");
                    err.printStackTrace();
                }

            }
            fr.close(); // closes the stream and release the resources

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}