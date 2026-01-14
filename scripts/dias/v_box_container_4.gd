extends VBoxContainer

func _process(delta):
	
	

	$preocupacion_nina.text = "Preocupación de Baba nina: " + str(GameManager.preocupacion_nina)

	$vida_nina.text = "Vida de Baba nina: " + str(GameManager.vida_nina)
	$preocupacion_mikhail.text = "Preocupación de Mikhail: " + str(GameManager.preocupacion_mikhail)

	$vida_mikhail.text = "Vida de Mikhail: " + str(GameManager.vida_mikhail)
	$preocupacion_viktor.text = "Preocupación de Viktor: " + str(GameManager.preocupacion_viktor)

	$vida_viktor.text = "Vida de Viktor: " + str(GameManager.vida_viktor)
