<%@page import="datos.Dt_tbl_moneda"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="entidades.Tbl_moneda, datos.Dt_tbl_moneda, java.util.ArrayList;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upload File xlsx</title>

</head>
<body>

<!-- <form enctype="multipart/form-data" method="post" onsubmit="return onSubmit();"> -->
<form id="frmTC" enctype="multipart/form-data" method="post">
	
	<fieldset>
		<legend>Tipo de Cambio Mensual</legend>
		<div align="center">
			<label>Seleccione el mes/año: </label>
			<input type="month" id="month" name="month" min="2000-01" max="2099-12" />
			<input type="text" id="mes" name="mes" />
			<input type="text" id="anio" name="anio" />
			<input type="text" id="opc" name="opc" />
		</div><br>
		<%
			Dt_tbl_moneda dtm = new Dt_tbl_moneda();
			ArrayList<Tbl_moneda> listM = new ArrayList<Tbl_moneda>();
			listM = dtm.listMonedas();
		%>
		<div align="center">
			<label>Moneda de Origen: </label>
			<select id="moneda1" name="moneda1" required="required">
				<option value="">Seleccione...</option>
				<%
					for(Tbl_moneda tm: listM){
				%>
				<option value="<%=tm.getId_moneda()%>"><%=tm.getSimbolo() +" | "+ tm.getNombre() %></option>				
				
				<% 
				}
				%>	
			</select>
		</div><br>
		<div align="center">
			<label>Moneda de Cambio: </label>
			<select id="moneda2" name="moneda2" required="required">
				<option value="">Seleccione...</option>
				<%
					for(Tbl_moneda tm: listM){
				%>
				<option value="<%=tm.getId_moneda()%>"><%=tm.getSimbolo() +" | "+ tm.getNombre() %></option>				
				
				<% 
				}
				%>	
			</select>
		</div><br>
	</fieldset>
	<hr>
	<fieldset>
		<legend>Deslizamiento monetario diario</legend>
		<div align="center">
			<input type="file" name="file" id="file" accept=".xlsx" />&nbsp;
			<button name="cargar" id="cargar" onclick="enviar('1');">Cargar</button>
		</div><br>
		<br>
		<div align="center">
			<table>
				<tbody id="tbody">
				</tbody>
			</table>
		</div>
	</fieldset>
	<hr>
	<div align="center">
		<button name="guardar" id="guardar" onclick="enviar('2');">Guardar</button>&nbsp;&nbsp;
		<input type="reset" name="cancelar" id="cancelar" value="Cancelar" />
<!-- 	<input type="submit" name="guardar" id="guardar" value="Guardar" />&nbsp;&nbsp; -->
	</div>
	
	
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function enviar(opcion){
	$("#opc").val(opcion);
	$("#frmTC").submit(function(event) {
	  event.preventDefault();
	  var formData = new FormData(this);
      $.ajax({
    	url : 'Sl_upload',
       type : 'POST',
       data : formData,
       success : function(data){
       console.log(data); 
   	   if(data == "1"){
	   	  window.location.assign('/Security/upload-file-xlsx.jsp');        
   	   }else{	
        	 var row = data;
             for(i =0 ; i < row.length ; i++){
                 var column = row[i];
                 var eachrow = "<tr>";
                 for(j =0 ; j < column.length ; j ++){    
                  eachrow = eachrow + "<td>"  + column[j] + "</td>";       
                 }
                 eachrow = eachrow + "</td>";
                 $('#tbody').append(eachrow);
             }
        } 	
       },
       cache : false,
       contentType : false,
       processData : false
      });
	});
}

 $(document).ready(function() {
    $("#month").change(function(){
    	var valor ="";
    	valor = $("#month").val();
    	$("#mes").val(valor.substring(5, 7));
        $("#anio").val(valor.substring(0, 4));
       });
    
    $("#cancelar").click(function(){
    	$('#tbody').empty();
       });

    });
</script>

</body>
</html>