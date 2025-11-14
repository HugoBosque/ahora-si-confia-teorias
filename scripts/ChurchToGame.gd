extends Area2D
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
@export var next_scene_path: String
@export var player_target_position: Vector2



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SceneManager.change_scene_with_player_position(next_scene_path, player_target_position)
