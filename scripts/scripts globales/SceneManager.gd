# SceneManager.gd
extends Node

var target_position: Vector2

func change_scene_with_player_position(scene_path: String, player_position: Vector2):
	target_position = player_position
	get_tree().change_scene_to_file(scene_path)
	call_deferred("_set_player_position")

func _set_player_position():
	await get_tree().process_frame
	await get_tree().process_frame  # Un frame más por seguridad
	
	# Método más robusto - buscar directamente en el árbol por grupo
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		players[0].global_position = target_position
		print("✅ Jugador encontrado en grupo 'player' y posicionado en: ", target_position)
	else:
		print("❌ No se encontró ningún nodo en el grupo 'player'")
		# Depuración adicional
		print("🔸 current_scene: ", get_tree().current_scene)
		print("🔸 Todos los grupos: ", get_tree().get_nodes_in_group(""))
