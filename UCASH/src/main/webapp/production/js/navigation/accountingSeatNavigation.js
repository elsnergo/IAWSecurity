var actions = [
	{
		"code": 97,
		"element": "cbxIDTD"
	}, 
	{
		"code": 98,
		"element": "cbxIDTCD"
	}, 
	{
		"code": 99,
		"element": "fecha"
	}, 
	{
		"code": 96,
		"element": "descripcion"
	}, 
	{
		"code": 101,
		"element": "cbxCC"
	}
	, 
	{
		"code": 102,
		"element": "debe"
	}, 
	{
		"code": 103,
		"element": "haber"
	}, 
	{
		"code": 13,
		"element": null, 
		"id" : "agregardet"
	},
	{
		"code": 46,
		"element": null, 
		"id" : "vaciardet"
	},
	{
		"code": 107,
		"element": null, 
		"id" : "btnGuardar"
	}
];

document.addEventListener("keydown", (event) => {
	for (var x = 0; x < actions.length; x++) {
		if (event.ctrlKey && event.keyCode == actions[x].code && actions[x].element != null) {
			event.preventDefault();
			$("#" + actions[x].element + "").focus();
		}else if(event.ctrlKey && event.keyCode == actions[x].code) {
			$("#" + actions[x].id + "").trigger("click");
		};
	};
});