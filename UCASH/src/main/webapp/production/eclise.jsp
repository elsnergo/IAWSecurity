<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="entidades.*, datos.*, java.util.*;"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="images/favicon.ico" type="image/ico" />
<title>Document</title>

<link href='https://fonts.googleapis.com/css?family=Roboto:400,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="../vendors/jqlistbox-master/docs/js/jqListbox.plugin-1.3.js"></script>

<style>
body {
	padding-bottom: 100px;
	font-family: 'Roboto', sans-serif;
	font-size: 16px;
}

.jumbotron {
	background-color: transparent;
	text-align: center;
	text-transform: uppercase;
	border-bottom: 1px solid #d1d1d1;
	box-shadow: 0 1px 0 #fff;
	border-radius: 0;
}

p>small {
	color: #aaa;
}

small.smaller {
	font-size: 14px;
	text-transform: none;
	display: block;
}

.customlist {
	background-color: #fff;
	border: 1px solid #999;
	height: 200px;
	overflow: auto;
	box-shadow: 0px 5px 5px #dfdfdf;
}

.customlist .tile {
	padding: 5px;
	margin: 5px 0;
	opacity: 0.75;
	border: 2px solid transparent;
	text-align: center;
	cursor: pointer;
}

.customlist .tile.selected {
	opacity: 1;
	border: 2px solid #E74C3C;
}

.customlist table {
	width: 100%;
}

.customlist table td {
	padding: 5px;
}

.customlist table tr {
	cursor: pointer;
}

.customlist table tr:hover {
	background-color: #eee;
}

.customlist ul {
	list-style-type: none;
	padding-left: 0;
	margin-left: -15px;
	margin-right: -15px;
}

.customlist ul li {
	padding: 5px;
	cursor: pointer;
	border-bottom: 1px solid #ddd;
}

.customlist ul li .glyphicon {
	/*padding-right: 10px;*/
	float: right;
	color: #000;
}

.customlist ul li.selected .glyphicon {
	color: #fff;
}

.customlist ul li .glyphicon-ok {
	color: #fff;
	float: none;
	padding-right: 10px;
}

.customlist ul li small {
	display: block;
}

.customlist ul li:hover {
	background-color: #eee;
}

.customlist ul li.selected {
	background-color: #E74C3C;
	font-weight: bold;
	color: #fff;
}
</style>

<script>
	Date.prototype.timeNow = function() {
		return ((this.getHours() < 10) ? "0" : "") + this.getHours() + ":"
				+ ((this.getMinutes() < 10) ? "0" : "") + this.getMinutes()
				+ ":" + ((this.getSeconds() < 10) ? "0" : "")
				+ this.getSeconds();
	}
</script>

</head>
<body>
	<form class="form-inline" align="center">
		<div style="margin-bottom: 40px;">
			<div class="form-group">
				<label class="col-form-label col-md-3 col-sm-3  label-align">
					Cuenta: </label>
				<div class="col-md-6 col-sm-6">
					<%
					ArrayList<Vw_catalogo_tipo_cuentacontable> listacc = new ArrayList<Vw_catalogo_tipo_cuentacontable>();
					Dt_cuentaContable dtcc = new Dt_cuentaContable();
					listacc = dtcc.listaCuentasContables();
					%>
					<select class="form-control js-example-basic-single" name="cbxIDTD"
						id="cbxdtcc" required="required">
						<option value="">Seleccione...</option>
						<%
						for (Vw_catalogo_tipo_cuentacontable td : listacc) {
						%>
						<option value="<%=td.getIdCuenta()%>"><%=td.getNumeroCuenta()%>
							/
							<%=td.getsC()%>/ /
							<%=td.getSsC()%> /
							<%=td.getSssC()%></option>
						<%
						}
						%>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-form-label col-md-3 col-sm-3  label-align">Debe</label>
				<div class="col-md-6 col-sm-6">
					<input class="form-control" class='optional' name="debe" id="debe"
						data-validate-length-range="5,15" type="text" required="required" />
				</div>
			</div>

			<div class="form-group">

				<label class="col-form-label col-md-3 col-sm-3  label-align">Haber</label>
				<div class="col-md-6 col-sm-6">
					<input class="form-control" class='optional' name="haber"
						id="haber" data-validate-length-range="5,15" type="text"
						required="required" />
				</div>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-6 customlist">
					<table id="example2">

					</table>
				</div>
				<div class="col-md-6">
					<a class="btn btn-success" id="example2-insert">Agregar</a> <a
						class="btn btn-danger" id="example2-remove">Borrar</a> <br> <br>
					<div class="alert alert-info" role="alert">
						Saldo: <span class="saldoTotal"></span>
					</div>

				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<br>

					<p>
						<span class="label label-success"><strong
							id="example2-count">0</strong> items</span> <span
							class="label label-primary"><strong id="example2-selected">0</strong>
							items selected</span>
					</p>
				</div>
			</div>
		</div>

	</form>


	<script>
		var debeTotal = 0;
		var haberTotal = 0;
		var saldo = 0;
		$('#example2')
				.jqListbox(
						{
							targetInput : '#target2',
							itemSelector : 'tr',
							selectedClass : false,
							initialValues : [

							],
							itemRenderer : function(item, pos, listbox) {
								var row = $('<tr><td><span class="glyphicon glyphicon-unchecked"></span></td><td>Cuenta: '
										+ item.Cuenta
										+ '</td><td>Debe: '
										+ item.Debe
										+ '</td><td>Haber: '
										+ item.Haber + '</td></tr>');
								if (listbox.isSelected(pos)) {
									row
											.find('td:first')
											.html(
													'<span class="glyphicon glyphicon-check"></span>');
									row.addClass('selected');
								}
								return row;
							},
							onBeforeRender : function(listbox) {
								if (listbox.countSelected() == 0) {
									$(
											'#example2-update,#example2-remove,#example2-moveup,#example2-movedown')
											.addClass('disabled');
								} else {
									$(
											'#example2-update,#example2-remove,#example2-moveup,#example2-movedown')
											.removeClass('disabled');
								}
							},
							onAfterRender : function(listbox) {
								var count = listbox.count();
								var selCount = listbox.countSelected();

								$('#example2-count').text(count);
								$('#example2-selected').text(selCount);

								if (count > 0 && count === selCount) {
									$('#example2-selected').text('All');
								}
							}
						});
		$('#example2-insert').click(function(e) {

			var cuenta = $("#cbxdtcc option:selected").text();
			var debe = parseInt($("#debe").val());
			var haber = parseInt($("#haber").val());
			var $example2 = $('#example2');
			$example2.jqListbox('insert', {
				'Cuenta' : cuenta,
				'Debe' : debe,
				'Haber' : haber
			});

			$example2.parent('div').scrollTop($example2.height());

			debeTotal += debe;
			haberTotal += haber;
			saldo = debeTotal - haberTotal;

			$('.saldoTotal').text(saldo);

		});
		$('#example2-remove').click(function(e) {
			if (confirm("Are you sure?")) {

				var $example2 = $('#example2');
				var items = $example2.jqListbox('getSelectedItems');

				for (var i = 0; i < items.length; i++) {
					saldo -= parseInt(items[i].Debe);
					saldo += parseInt(items[i].Haber);
				}

				$('.saldoTotal').text(saldo);

				$('#example2').jqListbox('remove');
			}
		});
	</script>
	<script>
		$(document).ready(function() {
			$.jAlert({
				'title' : 'It works!',
				'content' : 'YAY!',
				'theme' : 'green',
				'btns' : {
					'text' : 'close'
				}
			});
			alert("working");
		});
	</script>
</body>
</html>