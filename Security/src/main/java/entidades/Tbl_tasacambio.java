package entidades;

public class Tbl_tasacambio {
	
	//atributos
	private int id_tasaCambio;
	private int id_monedaO;
	private int id_monedaC;
	private String mes;
	private int anio;
	private int estado;
	
	//metodos
	public int getId_tasaCambio() {
		return id_tasaCambio;
	}
	public void setId_tasaCambio(int id_tasaCambio) {
		this.id_tasaCambio = id_tasaCambio;
	}
	public int getId_monedaO() {
		return id_monedaO;
	}
	public void setId_monedaO(int id_monedaO) {
		this.id_monedaO = id_monedaO;
	}
	public int getId_monedaC() {
		return id_monedaC;
	}
	public void setId_monedaC(int id_monedaC) {
		this.id_monedaC = id_monedaC;
	}
	public String getMes() {
		return mes;
	}
	public void setMes(String mes) {
		this.mes = mes;
	}
	public int getAnio() {
		return anio;
	}
	public void setAnio(int anio) {
		this.anio = anio;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	
}
