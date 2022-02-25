package datos;
import java.sql.Connection;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import org.apache.commons.dbcp.BasicDataSource;

public class poolConexion 
{
	//Atributos
	private static poolConexion INSTANCE = null;
	private static Connection con = null;
	private static BasicDataSource dataSource;
	private static String url = "jdbc:mysql://localhost:3306/seguridad?autoReconnect=true&useSSL=false&serverTimezone=UTC";
	private static String user = "root";
	private static String pass="Egonzalez87";

    //Constructor
	private poolConexion(){
		inicializaDataSource();
    }
	
	//Metodos
	private synchronized static void createInstance()
	{
		if(INSTANCE==null)
		{
			INSTANCE = new poolConexion();
		}
	}
	
	public static poolConexion getInstance()
	{
		if(INSTANCE == null)
		{
			createInstance();
		}
		return INSTANCE;
	}
	

    public final void inicializaDataSource(){
    	org.apache.commons.dbcp.BasicDataSource basicDataSource = new org.apache.commons.dbcp.BasicDataSource();
    	basicDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        basicDataSource.setUsername(user);
        basicDataSource.setPassword(pass);
        basicDataSource.setUrl(url);
        basicDataSource.setMaxActive(100);
        dataSource = basicDataSource;
    }
    
    public static boolean EstaConectado()
    {
    	boolean resp = false;
    	try{
    		// con = poolConexion.dataSource.getConnection();
    		if ((con==null) || (con.isClosed()))
    			resp = false;
    		else
    			resp = true;
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    		System.out.println(e.getMessage());
    	}
    	
    	return resp;
    }

    public static Connection getConnection() {	
	   if (EstaConectado()==false) {
		   		try {
					con = poolConexion.dataSource.getConnection();
					System.out.println("se conecto a BD SEGURIDAD!!!");
				} 
		   		catch (SQLException e) 
		   		{
					// TODO Auto-generated catch block
		   			e.printStackTrace();
		   			System.out.println(e.getMessage());
				}
		   }
	   return con;
    }
    
    public static void closeConnection(Connection con) {	
    	if (EstaConectado()!=false) {
    		try {
    			con.close();
    			System.out.println("Cerrando la Conexion");
    		} 
    		catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    			System.out.println(e.getMessage());
    		}
    	}
    }
   

	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		/*
			poolConexion.getInstance();
			Connection con = null;
	        
	        try {
		    	con = poolConexion.getConnection();
		    	if(con!=null){
		    		JOptionPane.showMessageDialog(null, "Conectado a BD Seguridad...");
		    		System.out.println("Conectado a BD Seguridad!!!");
		    	}
		    	else{
		    		JOptionPane.showMessageDialog(null, "Error al Conectar a BD Seguridad!!!");
		    		System.out.println("Error al Conectar a BD Seguridad!!!");
		    	}
	        }
	        finally{
	            try {
	               con.close();
	               System.out.println("Se desconectó de BD Seguridad!!!");
	            } 
	            catch (SQLException ex) {
	            	ex.printStackTrace();
	                System.out.println(ex.getMessage());
	            }
	        }
		*/
	}

}
