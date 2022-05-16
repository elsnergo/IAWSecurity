package servlets;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import datos.Dt_readExcelFile;
import datos.Dt_tbl_tasacambio;
import datos.Dt_tbl_tasacambio_det;
import entidades.Tbl_tasacambio;
import entidades.Tbl_tasacambio_det;

/**
 * Servlet implementation class Sl_upload
 */
@WebServlet("/Sl_upload")
public class Sl_upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	File file = null;
	int maxFileSize =  1024*1024;
	int maxBufferSize =  1024*1024;
	String fileStorePath = "C:\\temp1";
	String tempPath = "C:\\temp";

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("application/json;charset=iso-8859-1");
		request.setCharacterEncoding("iso-8859-1");

		String opt = "";
		String mes = "";
		int anio = 0;
		int monedaO = 0;
		int monedaC = 0;
		PrintWriter out = response.getWriter();
		Dt_readExcelFile dtref = new Dt_readExcelFile();
		Dt_tbl_tasacambio dtsc = new Dt_tbl_tasacambio();
		Dt_tbl_tasacambio_det dtscd = new Dt_tbl_tasacambio_det();
		
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		diskFileItemFactory.setSizeThreshold(maxBufferSize);
		diskFileItemFactory.setRepository(new File(tempPath));
		
		ServletFileUpload upload = new ServletFileUpload(diskFileItemFactory);
		upload.setFileSizeMax(maxFileSize);		
		try {
			List fileItem = upload.parseRequest(request);
			Iterator iterator = fileItem.iterator();
			
			while(iterator.hasNext()){
				FileItem file_item = (FileItem) iterator.next();
				if(file_item.isFormField()){
					String key = file_item.getFieldName();
					String valor = file_item.getString();
					if(key.equals("opc")){
						opt = valor;
					}
					if(key.equals("mes")){
						mes = valor;
					}
					if(key.equals("anio")){
						anio = Integer.parseInt(valor);
					}
					if(key.equals("moneda1")){
						monedaO = Integer.parseInt(valor);
					}
					if(key.equals("moneda2")){
						monedaC = Integer.parseInt(valor);
					}
				}
			}
			iterator = fileItem.iterator();
			while (iterator.hasNext()) {
				FileItem file_item = (FileItem) iterator.next();
				if(!file_item.isFormField()) {
					String file_name = file_item.getName();
					file = new File(fileStorePath + "\\" +file_name);
					file_item.write(file);
				}
			}
			
			
			if(!opt.equals("2")) {
				JSONArray array = dtref.readExcel(file.getAbsolutePath());
				out.print(array);
			}else {
				JSONArray array = dtref.readExcel2(file.getAbsolutePath());				
				var listcd = new ArrayList<Tbl_tasacambio_det>();				
				var tcd = new Tbl_tasacambio_det();				
				for (int i = 0; i < array.size(); i++) {
					JSONObject obj = (JSONObject) array.get(i);					
					if(i % 2 == 0) {
						var sdf = new SimpleDateFormat("dd/MM/yyyy");
						Date date = sdf.parse(obj.get("Fecha").toString());
						tcd.setFecha(new java.sql.Date(date.getTime()));
					} else {
						tcd.setTipoCambio(Double.parseDouble(obj.get("tipoCambio").toString()));
						listcd.add(tcd);
						tcd = new Tbl_tasacambio_det();
					}					
				}
					
				listcd.forEach(System.out::println);
				Tbl_tasacambio tsc = new Tbl_tasacambio();
				tsc.setMes(mes);
				tsc.setAnio(anio);
				tsc.setId_monedaO(monedaO);
				tsc.setId_monedaC(monedaC);
				int idTasac = 0;
				boolean guardado=false;
				idTasac = dtsc.guardarTasac(tsc);
				if(idTasac>0){
					for(Tbl_tasacambio_det tscd: listcd) {
						tscd.setId_tasacambio(idTasac);
						guardado=dtscd.guardarTasacd(tscd);
					}
					if(guardado) {
						response.getWriter().write("1");
						//response.sendRedirect("upload-file-xlsx.jsp?msj=1");
					}
					else {
						response.getWriter().write("3");
						//response.sendRedirect("upload-file-xlsx.jsp?msj=3");
					}
				}
				else {
					response.getWriter().write("2");
					//response.sendRedirect("upload-file-xlsx.jsp?msj=2");
				}
			}

		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
