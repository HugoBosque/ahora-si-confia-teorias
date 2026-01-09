extends VBoxContainer

func _process(delta):
	
	
	$preocupacion_tendero.text = "Preocupación de Ivan Petrovich: " + str(GameManager.preocupacion_tendero)
	
	$vida_tendero.text = "Vida de Ivan Petrovich: " + str(GameManager.vida_tendero)
	$preocupacion_medico.text = "Preocupación de Alina: " + str(GameManager.preocupacion_medico)

	$vida_medico.text = "Vida de Alina: " + str(GameManager.vida_medico)
	$preocupacion_viudo.text = "Preocupación de Romanov Morozov: " + str(GameManager.preocupacion_viudo)

	$vida_viudo.text = "Vida de Romanov Morozov: " + str(GameManager.vida_viudo)
	$preocupacion_yerik.text = "Preocupación de Yerik Pavel: " + str(GameManager.preocupacion_yerik)
	$vida_yerik.text = "Vida de Yerik Pavel: " + str(GameManager.vida_yerik)
