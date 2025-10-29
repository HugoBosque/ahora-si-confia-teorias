extends VBoxContainer

func _process(delta):
	$preocupacion_cura.text = "Preocupación del cura: " + str(GameManager.preocupacion_cura)
	$satisfaccion_cura.text = "Satisfaccion del cura: " + str(GameManager.satisfacion_cura)
	$vida_cura.text = "Vida del cura: " + str(GameManager.vida_cura)
	$preocupacion_esceptico.text = "Preocupacion del esceptico: " + str(GameManager.preocupacion_esceptico)
	$satisfaccion_esceptico.text = "Satisfaccion del esceptico: " + str(GameManager.satisfacion_esceptico)
	$vida_esceptico.text = "Vida del esceptico: " + str(GameManager.vida_esceptico)
	$preocupacion_madre.text = "Preocupacion de la madre: " + str(GameManager.preocupacion_madre)
	$satisfaccion_madre.text = "Satisfaccion de la madre: " + str(GameManager.satisfacion_madre)
	$vida_madre.text = "Vida de la madre: " + str(GameManager.vida_madre)

	
