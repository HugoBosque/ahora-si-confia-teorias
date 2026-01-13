extends Button  # este script va **directamente en el botón**

func _ready():
	pressed.connect(_on_button_pressed)  # conectar la señal pressed del mismo botón

func _on_button_pressed():
	# Cambiar a la escena final usando la ruta directamente
	GameManager.comprobar_vidas()
	get_tree().change_scene_to_file("res://scenes/cinemarografia/escena_final.tscn")
