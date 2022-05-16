package datos;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class Dt_readExcelFile {
	
	public JSONArray readExcel(String file_path) {
		JSONArray array = new JSONArray();
		
		try {
			Workbook workbook = WorkbookFactory.create(new File(file_path));//se abre el fichero
			Sheet sheet = workbook.getSheetAt(0); //se lee primero la hoja
			DataFormatter dataformatter = new DataFormatter();
			//Recorremos las filas de la hoja de calculo del libro de excel
			for(Row row: sheet) {
				JSONArray value = new JSONArray();
				for(Cell cell: row) {
					String cell_value = dataformatter.formatCellValue(cell);
					value.add(cell_value);
				}
				array.add(value);
			}
			workbook.close();//Cerramos el fichero
		} catch (EncryptedDocumentException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return array;
	}
	
    public String getValue(Cell cell,int rowNum,int index,Workbook book,boolean isKey) throws IOException{
    	String val = "";
    	if (cell == null || cell.getCellType()== CellType.BLANK ) {
	    	if (isKey) {
				book.close();
				throw new NullPointerException(String.format("the key on row %s index %s is null ", ++rowNum,++index));
			}else{
				return val;
			}
        }
        else {
            // 1. Tipo de cadena
        	CellType cellType = cell.getCellType();
        	if (Arrays.asList(CellType.STRING, CellType.NUMERIC).contains(cellType)) {
        		val = cellType == CellType.STRING ? cell.getStringCellValue() : String.valueOf(cell.getNumericCellValue());
        		if(index==0 && cellType==CellType.NUMERIC) {
        			Date date = cell.getDateCellValue();
        			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        			val = sdf.format(date);
        		}
		       if (val == null || val.trim().length()==0) {
		           if (book != null) {
		               book.close();
		           }
		           return val;
		       }
        	}
        }
    	return val.trim();
    }
	
	public JSONArray readExcel2(String file_path) {
		JSONArray array = new JSONArray();
		
		try {
			Workbook workbook = WorkbookFactory.create(new File(file_path));//se abre el fichero
			Sheet sheet = workbook.getSheetAt(0); //se lee primero la hoja
            int rowStart = sheet.getFirstRowNum (); // subíndice de la primera fila
            int rowEnd = sheet.getLastRowNum (); // subíndice de la última fila
            
            Row firstRow = sheet.getRow(rowStart);
            int cellStart = firstRow.getFirstCellNum();// subíndice de la primera columna
            int cellEnd = firstRow.getLastCellNum();// subíndice de la segunda columna
            
            Map<Integer, String> keyMap = new HashMap<Integer, String>();
            for (int j = cellStart; j < cellEnd; j++) {
                keyMap.put(j,getValue(firstRow.getCell(j), rowStart, j, workbook, true));
            }
            
            for(int i = rowStart+1; i <= rowEnd ; i++) {
                Row eachRow = sheet.getRow(i);
                for (int k = cellStart; k < cellEnd; k++) {
                	JSONObject obj = new JSONObject();
                	StringBuffer sb = new StringBuffer();
                    if (eachRow != null) {
                        String val = getValue(eachRow.getCell(k), i, k, workbook, false);
                        sb.append (val); // Se le agregan todos los datos para determinar si la fila está vacía
                        obj.put(keyMap.get(k),val);
                        System.out.println("obj"+obj.toString());
                    }
                    if (sb.toString().length() > 0) {
                        array.add(obj);
                    }
                }
            }
			workbook.close();//Cerramos el fichero
		} catch (EncryptedDocumentException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return array;
	}
	
}
