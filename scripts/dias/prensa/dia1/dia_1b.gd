extends Control

@onready var volver: Button = $volver

@onready var seguir: Button = $seguir



func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	volver.pressed.connect(_on_volver_pressed)
	seguir.pressed.connect(_on_seguir_pressed)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1a.tscn")


func _on_seguir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1c.tscn")
