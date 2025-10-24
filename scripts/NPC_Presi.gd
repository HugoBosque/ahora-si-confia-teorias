extends Area2D

const MY_DIALOGUE = preload("uid://dqx4dn8r3g2br")

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var player = get_node("../Player")  # ajustar según jerarquía real

var is_player_close = false
var is_dialogue_done = false

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	print("🎥 Escena NPC_Presi iniciada")

	# Mover jugador al spawn indicado
	if player:
		var spawn = get_node_or_null(Global.next_spawn_point)
		if spawn:
			player.global_position = spawn.global_position
			print("👣 Jugador colocado en:", Global.next_spawn_point)
		else:
			print("❌ Spawn no encontrado:", Global.next_spawn_point)

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

	if animation_player != null and animation_player.has_animation("acto1"):
		animation_player.play("acto1")

	print("🎞️ Cinemática terminada → yendo al mapa principal")
	Global.next_spawn_point = "Spawn_From_House"
	get_tree().change_scene_to_file("res://scenes/game.tscn")
