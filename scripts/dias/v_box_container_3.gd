extends VBoxContainer

func _process(delta):
	
	
	$preocupacion_tendero.text = "Preocupación del tendero: " + str(GameManager.preocupacion_tendero)
	$satisfaccion_tendero.text = "Satisfaccion del tendero: " + str(GameManager.satisfacion_tendero)
	$vida_tendero.text = "Vida del tendero: " + str(GameManager.vida_tendero)
	$preocupacion_medico.text = "Preocupación de la medico: " + str(GameManager.preocupacion_medico)
	$satisfaccion_medico.text = "Satisfaccion de la medico: " + str(GameManager.satisfacion_medico)
	$vida_medico.text = "Vida de la medico: " + str(GameManager.vida_medico)
	$preocupacion_viudo.text = "Preocupación del viudo: " + str(GameManager.preocupacion_viudo)
	$satisfaccion_viudo.text = "Satisfaccion del viudo: " + str(GameManager.satisfacion_viudo)
	$vida_viudo.text = "Vida del viudo: " + str(GameManager.vida_viudo)
