package entidades;

public class Tbl_user {
	
	//atributos
	private int id_user;
	private String user;
	private String pwd;
	private String nombres;
	private String apellidos;
	private String email;
	private String pwd_temp;
	private int estado;
	
	//metodos
	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd_temp() {
		return pwd_temp;
	}
	public void setPwd_temp(String pwd_temp) {
		this.pwd_temp = pwd_temp;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
		
}
