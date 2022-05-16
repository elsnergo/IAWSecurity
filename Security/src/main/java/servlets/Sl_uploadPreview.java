package servlets;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import datos.Dt_readExcelFile;

/**
 * Servlet implementation class Sl_uploadPreview
 */
@WebServlet("/Sl_uploadPreview")
public class Sl_uploadPreview extends HttpServlet {
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
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		//out.print("cargando...");
		
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		diskFileItemFactory.setSizeThreshold(maxBufferSize);
		diskFileItemFactory.setRepository(new File(tempPath));
		
		ServletFileUpload upload = new ServletFileUpload(diskFileItemFactory);
		upload.setFileSizeMax(maxFileSize);
		
		try {
			List fileItem = upload.parseRequest(request);
			Iterator iterator = fileItem.iterator();
			
			while (iterator.hasNext()) {
				FileItem file_item = (FileItem) iterator.next();
				if(!file_item.isFormField()) {
					String file_name = file_item.getName();
					file = new File(fileStorePath + "\\" +file_name);
					file_item.write(file);
				}
			}
			
			Dt_readExcelFile dtref = new Dt_readExcelFile();
			JSONArray array = dtref.readExcel(file.getAbsolutePath());
			out.print(array);
		
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
