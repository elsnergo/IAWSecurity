package entidades;

public class Tbl_moneda {
	
	//atributos
	private int id_moneda;
	private String nombre;
	private String simbolo;
	private int estado;
	
	//metodos
	public int getId_moneda() {
		return id_moneda;
	}
	public void setId_moneda(int id_moneda) {
		this.id_moneda = id_moneda;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getSimbolo() {
		return simbolo;
	}
	public void setSimbolo(String simbolo) {
		this.simbolo = simbolo;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
}
