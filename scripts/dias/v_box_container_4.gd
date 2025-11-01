extends VBoxContainer

func _process(delta):
	
	

	$preocupacion_nina.text = "Preocupación de la nina: " + str(GameManager.preocupacion_nina)
	$satisfaccion_nina.text = "Satisfaccion de la nina: " + str(GameManager.satisfacion_nina)
	$vida_nina.text = "Vida de la nina: " + str(GameManager.vida_nina)
	$preocupacion_mikhail.text = "Preocupación del mikhail: " + str(GameManager.preocupacion_mikhail)
	$satisfaccion_mikhail.text = "Satisfaccion del mikhail: " + str(GameManager.satisfacion_mikhail)
	$vida_mikhail.text = "Vida del mikhail: " + str(GameManager.vida_mikhail)
	$preocupacion_viktor.text = "Preocupación del viktor: " + str(GameManager.preocupacion_viktor)
	$satisfaccion_viktor.text = "Satisfaccion del viktor: " + str(GameManager.satisfacion_viktor)
	$vida_viktor.text = "Vida del viktor: " + str(GameManager.vida_viktor)
