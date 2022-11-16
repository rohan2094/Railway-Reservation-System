import java.sql.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

class QueryRunner implements Runnable {
    // Declare socket for client access
    protected Socket socketConnection;

    public QueryRunner(Socket clientSocket) {
        this.socketConnection = clientSocket;
    }

    public void run() {

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
            // Reading data from client
            InputStreamReader inputStream = new InputStreamReader(socketConnection.getInputStream());
            BufferedReader bufferedInput = new BufferedReader(inputStream);
            OutputStreamWriter outputStream = new OutputStreamWriter(socketConnection.getOutputStream());
            BufferedWriter bufferedOutput = new BufferedWriter(outputStream);
            PrintWriter printWriter = new PrintWriter(bufferedOutput, true);
            String clientCommand = "";
            String responseQuery = "";
            // Read client query from the socket endpoint
            clientCommand = bufferedInput.readLine();
            while (!clientCommand.equals("#")) {

                // System.out.println("Recieved data <" + clientCommand + "> from client : " +
                // socketConnection.getRemoteSocketAddress().toString());

                // Extracting input of train schedule

                String[] lyn = clientCommand.split("\\s+");
                Integer n = lyn.length;
                Integer tp = Integer.parseInt(lyn[0]);
                String[] allnames = new String[tp];

                Integer var = tp;
                

                if(n==1) break;
                System.out.println(var);
                for(int i=1;i<=var;i++)
                {
                    String pass_name = lyn[i];
                    int zzz =pass_name.length();
                    if(pass_name.charAt(zzz-1)==','){
                        pass_name = pass_name.substring(0, zzz-1);
                    }
                    allnames[i-1]= pass_name;
                    System.out.println(pass_name);
                    System.out.println(allnames[i-1]);
                    System.out.println("\n");
                }
                    try{
                        CallableStatement ste = connection.prepareCall("CALL book_ticket(?,?,?,?,?,?)");
                                ste.setInt(1, Integer.parseInt(lyn[n - 3])); // tid
                                ste.setString(2, lyn[n - 2]); // date
                                ste.setString(3, lyn[n - 1]); // ct
                                Array nm = connection.createArrayOf("varchar", allnames);
                                ste.setArray(4, nm); // passanger
                                ste.setInt(5, 123456789); // pnr
                                ste.setInt(6,tp); // total passanger
                                ste.execute();
                                ste.close();
                    } catch (Exception err) {
                        System.out.println("An error has occurred.");
                        System.out.println("See full details below.");
                        err.printStackTrace();
                    }
                

                /*****
                 * Your DB code goes here
                 ******/

                // Dummy response send to client
                responseQuery = "* Dummy result **";
                // Sending data back to the client
                printWriter.println(responseQuery);
                // Read next client query
                clientCommand = bufferedInput.readLine();
            }
            inputStream.close();
            bufferedInput.close();
            outputStream.close();
            bufferedOutput.close();
            printWriter.close();
            socketConnection.close();
        } catch (IOException e) {
            return;
        }
    }
}

/**
 * Main Class to controll the program flow
 */
public class ServiceModule {
    // Server listens to port
    static int serverPort = 7008;
    // Max no of parallel requests the server can process
    static int numServerCores = 5;
    // ------------ Main----------------------

    public static void main(String[] args) throws IOException {

        // Creating a thread pool
        ExecutorService executorService = Executors.newFixedThreadPool(numServerCores);

        try (// Creating a server socket to listen for clients
                ServerSocket serverSocket = new ServerSocket(serverPort)) {
            Socket socketConnection = null;

            // Always-ON server
            while (true) {
                System.out.println("Listening port : " + serverPort
                        + "\nWaiting for clients...");
                socketConnection = serverSocket.accept(); // Accept a connection from a client
                System.out.println("Accepted client :"
                        + socketConnection.getRemoteSocketAddress().toString()
                        + "\n");
                // Create a runnable task
                Runnable runnableTask = new QueryRunner(socketConnection);
                // Submit task for execution
                executorService.submit(runnableTask);
            }
        }
    }
}