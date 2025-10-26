extends Area2D

# Precargamos la escena como PackedScene
const GAME = preload("res://scenes/game.tscn")

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Cambia de escena usando PackedScene
		Global.player_spawn_position = Vector2(781.0, 167.0)
		get_tree().change_scene_to_file("res://scenes/game.tscn")
