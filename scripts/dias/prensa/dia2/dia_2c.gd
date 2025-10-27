extends Control
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
@onready var volver: Button = $volver
@onready var continuar: Button = $continuar

@export var continuar_player_position: Vector2 = Vector2(746, 369)
func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	volver.pressed.connect(_on_volver_pressed)
	continuar.pressed.connect(_on_continuar_pressed)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia2/dia_2b.tscn")

func _on_continuar_pressed() -> void:
	SceneManager.change_scene_with_player_position("res://scenes/House.tscn", continuar_player_position)
