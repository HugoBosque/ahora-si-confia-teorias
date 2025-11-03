extends VBoxContainer

func _process(delta):
	
	
	$preocupacion_cura.text = "Preocupación del cura: " + str(GameManager.preocupacion_cura)

	$vida_cura.text = "Vida del cura: " + str(GameManager.vida_cura)
	$preocupacion_esceptico.text = "Preocupacion del esceptico: " + str(GameManager.preocupacion_esceptico)

	$vida_esceptico.text = "Vida del esceptico: " + str(GameManager.vida_esceptico)
	$preocupacion_madre.text = "Preocupacion de la madre: " + str(GameManager.preocupacion_madre)

	$vida_madre.text = "Vida de la madre: " + str(GameManager.vida_madre)
