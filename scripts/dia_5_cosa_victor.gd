extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D

const SoldadoMuerto = preload("uid://cnfewcryynldq")
var player_in_area = false
var soldado_muerto_hablado = false
func _ready():
	sprite_2d.visible = false

	# Solo activo el personaje el día 5
	var activo := GameManager.dia == 5

	animated_sprite_2d.visible = activo
	character_body_2d.visible = activo
	character_body_2d.set_physics_process(activo)
	character_body_2d.set_process(activo)

	# Desactivar colisiones si no es día 5
	for child in character_body_2d.get_children():
		if child is CollisionShape2D:
			child.disabled = not activo

	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(area) -> void:
	if GameManager.dia == 5:
		if area.name == "Player":
			player_in_area = true
			sprite_2d.visible = true

func _on_body_exited(area) -> void:
	if GameManager.dia == 5:
		if area.name == "Player":
			player_in_area = false
			sprite_2d.visible = false
	
func _process(delta):
	if player_in_area and Input.is_action_just_pressed("accept") and not GameManager.is_dialogue_active and not soldado_muerto_hablado:
		DialogueManager.show_dialogue_balloon(SoldadoMuerto, "start")
		soldado_muerto_hablado = true
		desactivar_soldado()
		
func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false

	
func desactivar_soldado():
	sprite_2d.visible = false
	animated_sprite_2d.visible = false
	player_in_area = false

	for child in character_body_2d.get_children():
		if child is CollisionShape2D:
			child.disabled = true

	character_body_2d.set_physics_process(false)
	character_body_2d.set_process(false)
