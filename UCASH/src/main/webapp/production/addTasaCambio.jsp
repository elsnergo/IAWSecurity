<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.ArrayList;"%>

<%
//INVALIDA LA CACHE DEL NAVEGADOR //
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
response.setDateHeader("Expires", -1);

//DECLARACIONES
Vw_usuariorol vwur = new Vw_usuariorol();
Dt_rolOpciones dtro = new Dt_rolOpciones();
ArrayList<Vw_rolopciones> listOpc = new ArrayList<Vw_rolopciones>();
boolean permiso = false; //VARIABLE DE CONTROL

//OBTENEMOS LA SESION
vwur = (Vw_usuariorol) session.getAttribute("acceso");
if (vwur != null) {
	//OBTENEMOS LA LISTA DE OPCIONES ASIGNADAS AL ROL

	listOpc = dtro.ObtenerRolOpcionPorIdLogin(vwur.getIdUsuarioRol());

	for (int x = 0; x < listOpc.size(); x++) {
		System.out.print(listOpc.get(x).getOpciones());
	} ;

	//RECUPERAMOS LA URL = MI OPCION ACTUAL
	int index = request.getRequestURL().lastIndexOf("/");
	String miPagina = request.getRequestURL().substring(index + 1);

	//VALIDAR SI EL ROL CONTIENE LA OPCION ACTUAL DENTRO DE LA MATRIZ DE OPCIONES
	for (Vw_rolopciones vrop : listOpc) {
		if (vrop.getOpciones().trim().equals(miPagina.trim())) {
	permiso = true; //ACCESO CONCEDIDO
	System.out.print("ESTA ES LA PAGINA RECUPERADA: " + " " + vrop.getOpciones().trim() + " "
			+ "ESTA ES LA PAGINA EN LA QUE NOS ENCONTRAMOS: " + miPagina.trim());
	break;
		}
	}
} else {
	response.sendRedirect("../login.jsp?msj=401");
	return;
}

if (!permiso) {
	response.sendRedirect("page_403.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<!-- <meta charset=ISO-8859-1> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Agregar | Tasa Cambio</title>

<!-- Bootstrap -->
<link href="../vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../vendors/nprogress/nprogress.css" rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="navegacion.jsp"></jsp:include>
		</div>


		<!-- page content -->
		<div class="right_col" role="main">
			<div class="">
				<div class="page-title">
					<div class="title_left">
						<h3>Agregar Tasa Cambio</h3>
					</div>

					<div class="title_right">
						<div class="col-md-3 col-sm-3 form-group pull-right top_search">
							<br><br> 
							<a target="_blank" 
								href="https://www.bcn.gob.ni/IRR/tipo_cambio_mensual/index.php" 
								class="badge badge-info">
								Tipo de Cambio Oficial - BCN
							</a>
						</div>
					</div>
				</div>
				<div class="clearfix"></div>

				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="x_panel">
							<div class="x_title">
								<h2>Agregar Tasa Cambio</h2>
								
								<div class="clearfix"></div>
							</div>

							<div class="x_content">
								<form id="frmTC" enctype="multipart/form-data" method="post">

									<fieldset>
										<legend>Tipo de Cambio Mensual</legend>
										<div class=" form-group">
											<div align="center">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Seleccione
													el mes/año: </label>
												<div class="col-md-6 col-sm-6">
													<input class="form-control js-example-basic-single"
														type="month" id="month" name="month" min="2000-01"
														max="2099-12" /> <input type="hidden" id="mes" name="mes" />
													<input type="hidden" id="anio" name="anio" /> <input
														type="hidden" id="opc" name="opc" />
												</div>
											</div>
										</div>
										<br> <br> <br>
										<%
										Dt_moneda dtm = new Dt_moneda();
										ArrayList<Tbl_moneda> listM = new ArrayList<Tbl_moneda>();
										listM = dtm.listaMonedasActivas();
										%>
										<div class="  form-group">
											<div align="center">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Moneda
													de Origen: </label>
												<div class="col-md-6 col-sm-6">
													<select class="form-control js-example-basic-single"
														id="moneda1" name="moneda1" required="required">
														<option value="">Seleccione...</option>
														<%
														for (Tbl_moneda tm : listM) {
														%>
														<option value="<%=tm.getIdMoneda()%>"><%=tm.getSimbolo() + " | " + tm.getNombre()%></option>

														<%
														}
														%>
													</select>
												</div>
											</div>
										</div>
										<br> <br> <br>
										<div class="  form-group">
											<div align="center">
												<label class="col-form-label col-md-3 col-sm-3  label-align">Moneda
													de Cambio: </label>
												<div class="col-md-6 col-sm-6">
													<select class="form-control js-example-basic-single"
														id="moneda2" name="moneda2" required="required">
														<option value="">Seleccione...</option>
														<%
														for (Tbl_moneda tm : listM) {
														%>
														<option value="<%=tm.getIdMoneda()%>"><%=tm.getSimbolo() + " | " + tm.getNombre()%></option>

														<%
														}
														%>
													</select>
												</div>
											</div>
										</div>
										<br>
									</fieldset>
									<hr>
									<fieldset>
										<legend>Deslizamiento monetario diario</legend>

										<div align="center">
											<input class="btn btn-outline-secondary" type="file"
												name="file" id="file" accept=".xlsx" />&nbsp;
											<button class="btn btn-secondary" name="cargar" id="cargar"
												onclick="enviar('1');">Cargar</button>
										</div>
										<br> <br>
										<div align="center">
											<table>
												<tbody id="tbody">
												</tbody>
											</table>
										</div>
									</fieldset>
									<hr>
									<div align="center">
										<button class="btn btn-primary name=" guardar" id="guardar"
											onclick="enviar('2');">Agregar</button>
											&nbsp;&nbsp;
										<a href="tbl_tasaCambio.jsp" class="btn btn-danger">Cancelar</a> 
										<!-- <input class="btn btn-danger" type="reset" name="cancelar" id="cancelar" value="Cancelar" /> -->
										<!-- <input type="submit" name="guardar" id="guardar" value="Guardar" />&nbsp;&nbsp; -->
									</div>


								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /page content -->

		<!-- footer content -->
		<footer>
			<div class="pull-right">UCASH >> Sistema contable</div>
			<div class="clearfix"></div>
		</footer>
		<!-- /footer content -->
	</div>


	<script src="../vendors/validator/multifield.js"></script>
	<script src="../vendors/validator/validator.js"></script>

	<!-- Javascript functions	-->


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	
	  var flag = 2; 

	  function enviar(opcion){
	      $("#opc").val(opcion);
	      $("#frmTC").submit(function(event) {
	        event.preventDefault();
	        var formData = new FormData(this);
	        if(flag > 0){
	            console.log(flag);
	            $.ajax({
	                  url : '../Sl_upload',
	                 type : 'POST',
	                 data : formData,
	                 success : function(data){
	                 
	                    if(data == "1"){
	                       window.location.assign('/UCASH/production/tbl_tasaCambio.jsp?msj=1');        
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
	            flag--; 
	        }
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


	<!-- jQuery -->
	<script src="../vendors/jquery/dist/jquery.min.js"></script>
	<!-- jAlert -->
	<script src="../vendors/jAlert/dist/jAlert.min.js"></script>
	<script src="../vendors/jAlert/dist/jAlert-functions.min.js"></script>
	<!-- Bootstrap -->
	<script src="../vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- FastClick -->
	<script src="../vendors/fastclick/lib/fastclick.js"></script>
	<!-- NProgress -->
	<script src="../vendors/nprogress/nprogress.js"></script>
	<!-- validator -->
	<!-- <script src="../vendors/validator/validator.js"></script> -->


	<!-- Custom Theme Scripts -->
	<script src="../build/js/custom.min.js"></script>

</body>
</html>