extends VBoxContainer

func _process(delta):
	$preocupacion_cura.text = "Preocupación del cura: " + str(GameManager.preocupacion_cura)
	$satisfaccion_cura.text = "Satisfaccion del cura: " + str(GameManager.satisfacion_cura)
