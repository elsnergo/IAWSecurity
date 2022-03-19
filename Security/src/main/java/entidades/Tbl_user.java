package entidades;
import java.sql.Timestamp;

public class Tbl_user {
	
	//atributos
	private int id_user;
	private String user;
	private String pwd;
	private String nombres;
	private String apellidos;
	private String email;
	private String pwd_temp;
	private String urlFoto;
	private String codVerificacion;
	private String key_encriptacion;
	private int estado;
	private int usuario_creacion;
	private Timestamp fecha_creacion;
	private int usuario_edicion;
	private Timestamp fecha_edicion;
	private int usuario_eliminacion;
	private Timestamp fecha_eliminacion;
	
	//metodos
	public int getId_user() {
		return id_user;
	}
	public String getUrlFoto() {
		return urlFoto;
	}
	public void setUrlFoto(String urlFoto) {
		this.urlFoto = urlFoto;
	}
	public String getCodVerificacion() {
		return codVerificacion;
	}
	public void setCodVerificacion(String codVerificacion) {
		this.codVerificacion = codVerificacion;
	}
	public String getKey_encriptacion() {
		return key_encriptacion;
	}
	public void setKey_encriptacion(String key_encriptacion) {
		this.key_encriptacion = key_encriptacion;
	}
	public int getUsuario_creacion() {
		return usuario_creacion;
	}
	public void setUsuario_creacion(int usuario_creacion) {
		this.usuario_creacion = usuario_creacion;
	}
	public Timestamp getFecha_creacion() {
		return fecha_creacion;
	}
	public void setFecha_creacion(Timestamp fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}
	public int getUsuario_edicion() {
		return usuario_edicion;
	}
	public void setUsuario_edicion(int usuario_edicion) {
		this.usuario_edicion = usuario_edicion;
	}
	public Timestamp getFecha_edicion() {
		return fecha_edicion;
	}
	public void setFecha_edicion(Timestamp fecha_edicion) {
		this.fecha_edicion = fecha_edicion;
	}
	public int getUsuario_eliminacion() {
		return usuario_eliminacion;
	}
	public void setUsuario_eliminacion(int usuario_eliminacion) {
		this.usuario_eliminacion = usuario_eliminacion;
	}
	public Timestamp getFecha_eliminacion() {
		return fecha_eliminacion;
	}
	public void setFecha_eliminacion(Timestamp fecha_eliminacion) {
		this.fecha_eliminacion = fecha_eliminacion;
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
