extends Area2D

@export var target_scene_path: String = "res://scenes/game.tscn"
@export var target_spawn_name: String = "Spawn_From_House"

var _target_scene: PackedScene

func _ready():
	# Precargamos el pueblo
	_target_scene = ResourceLoader.load(target_scene_path)

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	# 🔹 Desactivar todas las puertas de la casa para evitar teleports
	var parent_map = get_parent()
	if parent_map:
		for area in get_tree().get_nodes_in_group("door_triggers"):
			area.set_monitoring(false)

	# 🔹 Instanciamos el pueblo
	var town_instance = _target_scene.instantiate()
	get_tree().root.add_child(town_instance)

	# 🔹 Movemos al jugador al spawn dentro del pueblo
	var player = body
	if town_instance.has_node(target_spawn_name):
		var spawn = town_instance.get_node(target_spawn_name)
		player.global_position = spawn.global_position

	# 🔹 Ocultamos la casa y la liberamos
	if parent_map:
		parent_map.visible = false
	await get_tree().process_frame
	if parent_map:
		parent_map.queue_free()
