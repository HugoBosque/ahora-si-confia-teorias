extends Control

@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
@onready var volver: Button = $volver

@onready var seguir: Button = $seguir
@export var siguiente: String
@export var anterior: String


func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	volver.pressed.connect(_on_volver_pressed)
	seguir.pressed.connect(_on_seguir_pressed)


func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file(anterior)


func _on_seguir_pressed() -> void:
	get_tree().change_scene_to_file(siguiente)
