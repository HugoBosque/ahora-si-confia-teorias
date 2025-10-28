extends Area2D

@export var target_scene_path: String = "res://scenes/House.tscn"
@export var player_target_position: Vector2

func _on_body_entered(body):
	if body.is_in_group("player"):
		SceneManager.change_scene_with_player_position(target_scene_path, player_target_position)
