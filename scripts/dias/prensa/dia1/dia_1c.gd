extends Control
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
@onready var volver: Button = $volver
@onready var continuar: Button = $continuar

# Solo exporta la posición para el botón continuar
@export var continuar_player_position: Vector2 = Vector2(746, 369)

func _ready() -> void:
	volver.pressed.connect(_on_volver_pressed)
	continuar.pressed.connect(_on_continuar_pressed)

func _on_volver_pressed() -> void:
	# Este se queda igual, sin SceneManager
	get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1b.tscn")

func _on_continuar_pressed() -> void:
	# Solo este usa el SceneManager para posicionar al jugador
	SceneManager.change_scene_with_player_position("res://scenes/House.tscn", continuar_player_position)
