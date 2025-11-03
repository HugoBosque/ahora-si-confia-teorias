extends VBoxContainer

func _process(delta):
	
	

	$preocupacion_nina.text = "Preocupación de la nina: " + str(GameManager.preocupacion_nina)

	$vida_nina.text = "Vida de la nina: " + str(GameManager.vida_nina)
	$preocupacion_mikhail.text = "Preocupación del mikhail: " + str(GameManager.preocupacion_mikhail)

	$vida_mikhail.text = "Vida del mikhail: " + str(GameManager.vida_mikhail)
	$preocupacion_viktor.text = "Preocupación del viktor: " + str(GameManager.preocupacion_viktor)

	$vida_viktor.text = "Vida del viktor: " + str(GameManager.vida_viktor)
