extends Control

@onready var volver: Button = $volver
@onready var continuar: Button = $continuar


func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	volver.pressed.connect(_on_volver_pressed)
	continuar.pressed.connect(_on_continuar_pressed)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1b.tscn")

func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/House.tscn")
