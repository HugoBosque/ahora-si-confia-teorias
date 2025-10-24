extends Area2D

@export var target_scene: String = "res://scenes/game.tscn"
@export var target_spawn: String = "Spawn_From_House"
@export var first_time_spawn: String = "Spawn_From_House_Intro"
@export var first_time_scene: String = "res://scenes/1.tscn" # La "cinemática"

var _triggered: bool = false

func _on_body_entered(body):
	if _triggered:
		return
	if not body.is_in_group("player"):
		return

	_triggered = true
	set_monitoring(false)
	
	print("🚪 Jugador entró. has_seen_presi_scene =", Global.has_seen_presi_scene)

	if not Global.has_seen_presi_scene:
		Global.has_seen_presi_scene = true
		Global.next_spawn_point = first_time_spawn
		print("🎬 Primera vez → cambiando a", first_time_scene, "con spawn", first_time_spawn)
		get_tree().change_scene_to_file(first_time_scene)
	else:
		Global.next_spawn_point = target_spawn
		print("➡️ Ya ha visto la escena → cambiando a", target_scene, "con spawn", target_spawn)
		get_tree().change_scene_to_file(target_scene)
	if body.is_in_group("player"):
		Global.next_spawn_point = target_spawn

		print("¿Ya entró una vez?:", Global.has_seen_presi_scene)

		if not Global.has_seen_presi_scene:
			Global.has_seen_presi_scene = true
			get_tree().change_scene_to_file(first_time_scene)
		else:
			get_tree().change_scene_to_file(target_scene)
