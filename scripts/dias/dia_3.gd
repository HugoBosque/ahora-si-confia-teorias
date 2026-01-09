extends VBoxContainer

func _process(delta):
	
	
	$preocupacion_cura.text = "Preocupación del Padre Zhukov: " + str(GameManager.preocupacion_cura)

	$vida_cura.text = "Vida del Padre Zhukov: " + str(GameManager.vida_cura)
	$preocupacion_esceptico.text = "Preocupacion de Alexei: " + str(GameManager.preocupacion_esceptico)

	$vida_esceptico.text = "Vida de Alexei: " + str(GameManager.vida_esceptico)
	$preocupacion_madre.text = "Preocupacion de Svetlana: " + str(GameManager.preocupacion_madre)

	$vida_madre.text = "Vida de Svetlana: " + str(GameManager.vida_madre)
