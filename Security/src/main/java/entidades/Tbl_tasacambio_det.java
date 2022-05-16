package entidades;
import java.sql.Date;

public class Tbl_tasacambio_det {

	//atributos
	private int id_tasacambio_det;
	private int id_tasacambio;
	private Date fecha;
	private double tipoCambio;
	
	//metodos
	public int getId_tasacambio_det() {
		return id_tasacambio_det;
	}
	public void setId_tasacambio_det(int id_tasacambio_det) {
		this.id_tasacambio_det = id_tasacambio_det;
	}
	public int getId_tasacambio() {
		return id_tasacambio;
	}
	public void setId_tasacambio(int id_tasacambio) {
		this.id_tasacambio = id_tasacambio;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public double getTipoCambio() {
		return tipoCambio;
	}
	public void setTipoCambio(double tipoCambio) {
		this.tipoCambio = tipoCambio;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return String.format("Fecha: %s, TipoCambio: %s", fecha, tipoCambio);
	}

}
