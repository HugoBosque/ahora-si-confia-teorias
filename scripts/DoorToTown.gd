extends Area2D

@export var target_scene_path: String = "res://scenes/game.tscn"
@export var player_target_position: Vector2

func _on_body_entered(body):
	if not GameManager.has_done_cinematic1:
		get_tree().change_scene_to_file("res://scenes/cinemarografia/cinematica1.tscn")
		GameManager.has_done_cinematic1 = true
	else:
		if body.is_in_group("player"):
			SceneManager.change_scene_with_player_position(target_scene_path, player_target_position)
