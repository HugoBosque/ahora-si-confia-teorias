extends Area2D

const MY_DIALOGUE = preload("uid://dqx4dn8r3g2br")

@onready var animation_player: AnimationPlayer = find_animation_player()
@onready var player = get_node("../Player")

var is_player_close = false
var is_dialogue_done = false

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	print("🎥 Escena NPC_Presi iniciada")
	# Aquí puedes mover el jugador al spawn indicado
	var player = get_node_or_null("Player") # ajusta el path si está anidado
	if player:
		var spawn = get_node_or_null(Global.next_spawn_point)
		if spawn:
			player.global_position = spawn.global_position
			print("👣 Jugador colocado en:", Global.next_spawn_point)
	# Verifica que animation_player no sea null
	if animation_player == null:
		print("Error: AnimationPlayer no encontrado en la escena")
		# Intenta buscar nuevamente después de un frame
		await get_tree().process_frame
		animation_player = find_animation_player()
		if animation_player != null:
			print("AnimationPlayer encontrado después de retry: ", animation_player.name)
	else:
		print("AnimationPlayer encontrado: ", animation_player.name)

func find_animation_player() -> AnimationPlayer:
	# Método 1: Buscar en el árbol desde este nodo
	var scene_root = get_tree().root
	var animation_player = _find_animation_player_recursive(scene_root)
	
	if animation_player:
		return animation_player
	
	# Método 2: Buscar en el árbol de escenas
	for scene in get_tree().get_nodes_in_group("persistent_nodes"):
		animation_player = _find_animation_player_recursive(scene)
		if animation_player:
			return animation_player
	
	# Método 3: Buscar en toda la escena actual
	return _find_animation_player_recursive(get_tree().current_scene)

func _find_animation_player_recursive(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node
	
	for child in node.get_children():
		var result = _find_animation_player_recursive(child)
		if result:
			return result
	
	return null

func _process(delta: float) -> void:
	if is_player_close and not GameManager.is_dialogue_active and not is_dialogue_done:
		DialogueManager.show_dialogue_balloon(MY_DIALOGUE, "start")

func _on_area_entered(area):
	is_player_close = true

func _on_area_exited(area: Area2D) -> void:
	is_player_close = false

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true
	if player:
		player.set_movement_enabled(false)

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
	is_dialogue_done = true
	
	# Verifica antes de reproducir la animación
	if animation_player != null:
		if animation_player.has_animation("acto1"):
			animation_player.play("acto1")
		else:
			print("Error: La animación 'acto1' no existe")
			print("Animaciones disponibles: ", animation_player.get_animation_list())
	else:
		print("Error: No se puede reproducir animación, AnimationPlayer no disponible")
		# Último intento de encontrar el AnimationPlayer
		animation_player = find_animation_player()
		if animation_player != null:
			print("AnimationPlayer encontrado finalmente, reproduciendo animación")
			animation_player.play("acto1")
			
	print("🎞️ Cinemática terminada → yendo al mapa principal")
	Global.next_spawn_point = "Spawn_From_House"
	get_tree().change_scene_to_file("res://scenes/game.tscn")
