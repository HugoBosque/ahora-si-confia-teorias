extends Area2D

@export var target_scene_path: String = "res://scenes/House.tscn"
@export var target_spawn_name: String = "Spawn_From_Town"

var _target_scene: PackedScene

func _ready():
	# Precargamos la casa
	_target_scene = ResourceLoader.load(target_scene_path)

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	Global.next_spawn_point = target_spawn_name
	print("➡️ Entrando a casa:", target_scene_path, "con spawn:", target_spawn_name)

	# 🔹 Desactivar todas las puertas del mapa viejo para evitar teleports
	var parent_map = get_parent()
	if parent_map:
		for area in get_tree().get_nodes_in_group("door_triggers"):
			area.set_monitoring(false)

	# 🔹 Instanciamos la casa
	var house_instance = _target_scene.instantiate()
	get_tree().root.add_child(house_instance)

	# 🔹 Movemos al jugador al spawn dentro de la casa
	var player = body
	if house_instance.has_node(target_spawn_name):
		var spawn = house_instance.get_node(target_spawn_name)
		player.global_position = spawn.global_position

	# 🔹 Ocultamos el mapa viejo y lo liberamos en segundo plano
	if parent_map:
		parent_map.visible = false
	await get_tree().process_frame
	if parent_map:
		parent_map.queue_free()
