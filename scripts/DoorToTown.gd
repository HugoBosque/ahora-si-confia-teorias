extends Area2D

@export var target_scene: String = "res://scenes/1.tscn"
@export var target_spawn: String = "Spawn_From_House"

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.next_spawn_point = target_spawn
		get_tree().change_scene_to_file(target_scene)
