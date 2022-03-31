package entidades;

public class Tbl_user2 {
	
	//Atributos
	private int id_user;
	private String token; //key_encriptacion
	
	//Metodos
	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	
}
