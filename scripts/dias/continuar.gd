extends Control

@onready var button: Button = $Button

func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Cambiar a la escena que quieras
	get_tree().change_scene_to_file("res://scenes/House.tscn")
