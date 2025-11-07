extends Control
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
@onready var button: Button = $Button
@export var continuar_player_position: Vector2 = Vector2(712, 227)
func _ready() -> void:
	# Conectar la señal pressed del botón a una función
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Cambiar a la escena que quieras
	SceneManager.change_scene_with_player_position("res://scenes/video_stream_player.tscn", continuar_player_position)
