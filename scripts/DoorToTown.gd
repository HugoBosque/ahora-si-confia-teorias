extends Area2D

@export var target_scene: String = "res://scenes/game.tscn"
@export var target_spawn: String = "Spawn_From_House"

var _triggered: bool = false

func _on_body_entered(body):
	if _triggered or not body.is_in_group("player"):
		return

	_triggered = true
	set_monitoring(false)

	# Guardamos el spawn del jugador en Global
	Global.next_spawn_point = target_spawn
	print("➡️ Cambiando a game.tscn con spawn:", target_spawn)
	get_tree().change_scene_to_file(target_scene)
