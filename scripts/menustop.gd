extends Control

@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
var location
var swapn

func _ready() -> void:
	$continuar.pressed.connect(_on_button_pressed)

	$salir.pressed.connect(_on_button_3_pressed)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(house_scene)


func _on_button_3_pressed() -> void:
	get_tree().quit()
