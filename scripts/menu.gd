extends Control

# Precargamos la escena del juego (ajusta la ruta si tu archivo está en otra carpeta)
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")


func _ready() -> void:
	# Conecta los botones (cambia los nombres si tus nodos se llaman distinto)
	$Play.pressed.connect(_on_play_pressed)
	$Salir.pressed.connect(_on_salir_pressed)

func _on_play_pressed() -> void:
	# Cambia de escena al juego (rápido porque ya está precargado)
	get_tree().change_scene_to_packed(house_scene)


func _on_salir_pressed() -> void:
	get_tree().quit()
