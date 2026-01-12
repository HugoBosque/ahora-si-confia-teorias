extends Node2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D2
@onready var sprite_exclamacion: Sprite2D = $Sprite2D
@onready var papel_animated: AnimatedSprite2D = $AnimatedSprite2D

const SoldadoMuerto = preload("uid://cnfewcryynldq")

var player_in_area := false
var dialogo_lanzado := false

func _ready():
	sprite_exclamacion.visible = false

func _process(_delta):
	if GameManager.dia != 5:
		return

	# Detectar si el jugador está “cerca” del nodo (simulando área)
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		var player_body = players[0]
		if player_body.global_position.distance_to(global_position) < 50:  # ajusta radio
			if not player_in_area:
				player_in_area = true
				sprite_exclamacion.visible = true
		else:
			if player_in_area:
				player_in_area = false
				sprite_exclamacion.visible = false

	# Interacción
	if player_in_area and not dialogo_lanzado and not GameManager.is_dialogue_active:
		if Input.is_action_just_pressed("interact"):
			_iniciar_dialogo()

func _iniciar_dialogo():
	dialogo_lanzado = true
	sprite_exclamacion.visible = false
	GameManager.is_dialogue_active = true
	DialogueManager.show_dialogue_balloon(SoldadoMuerto, "start")
