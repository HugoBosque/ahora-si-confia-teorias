extends Control
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")


@onready var seguir: Button = $seguir



func _ready() -> void:

	seguir.pressed.connect(_on_seguir_pressed)


func _on_seguir_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1b.tscn")
