extends VBoxContainer

func _process(delta):
	
	
	$preocupacion_tendero.text = "Preocupación del Ivan Petrovich: " + str(GameManager.preocupacion_tendero)
	
	$vida_tendero.text = "Vida del Ivan Petrovich: " + str(GameManager.vida_tendero)
	$preocupacion_medico.text = "Preocupación de Alina: " + str(GameManager.preocupacion_medico)

	$vida_medico.text = "Vida de Alina: " + str(GameManager.vida_medico)
	$preocupacion_viudo.text = "Preocupación del Romanov Morozov: " + str(GameManager.preocupacion_viudo)

	$vida_viudo.text = "Vida del Romanov Morozov: " + str(GameManager.vida_viudo)
