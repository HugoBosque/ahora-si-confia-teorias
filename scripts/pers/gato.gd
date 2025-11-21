extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var character_body: CharacterBody2D = $CharacterBody2D

const GATO = preload("uid://cdb2neyc8mx1d")

var player_close: bool = false

func _ready() -> void:
	# EL GATO SOLO EXISTE EN EL DÍA 3
	if GameManager.dia != 3:
		_hide_cat_completely()
		return
	
	self.visible = true
	self.monitoring = true

	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _process(delta):
	if player_close \
	and Input.is_action_just_pressed("ui_accept") \
	and not GameManager.is_dialogue_active:
		DialogueManager.show_dialogue_balloon(GATO, "start")


func _on_area_entered(area: Area2D) -> void:
	sprite_2d.visible = true
	player_close = true

func _on_area_exited(area: Area2D) -> void:
	sprite_2d.visible = false
	player_close = false


func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true


func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false

	# SI ES DÍA 3, EL GATO DESAPARECE TRAS EL DIÁLOGO
	if GameManager.dia == 3:
		_hide_cat_completely()


# -------------------------------------------------------
# ❌ FUNCIÓN PARA OCULTAR AL GATO Y TODAS SUS COLISIONES
# -------------------------------------------------------
func _hide_cat_completely():
	# Ocultar visualmente
	self.visible = false
	sprite_2d.visible = false

	# Desactivar área
	self.monitoring = false

	# Desactivar CharacterBody2D
	character_body.visible = false
	character_body.collision_layer = 0
	character_body.collision_mask = 0
	character_body.set_physics_process(false)
	character_body.set_process(false)
