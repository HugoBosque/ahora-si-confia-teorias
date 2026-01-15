extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

const SoldadoMuerto = preload("uid://cnfewcryynldq")

var player_in_area = false
var dialogo_activo := false

func _ready():
	sprite_2d.visible = false
	sprite_2d_2.visible = false

	# 🔔 CONECTAR SEÑALES DEL DIÁLOGO
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	# Si ya se habló, no aparece nunca más
	if Global.soldado_muerto_hablado:
		desactivar_soldado()
		return

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
	if Global.soldado_muerto_hablado:
		return

	if GameManager.dia == 5 and area.name == "Player":
		player_in_area = true
		sprite_2d.visible = true

func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		sprite_2d.visible = false

func _process(delta):
	if player_in_area \
	and Input.is_action_just_pressed("accept") \
	and not GameManager.is_dialogue_active \
	and not Global.soldado_muerto_hablado:

		sprite_2d_2.visible = true           # 📸 Foto aparece
		dialogo_activo = true
		Global.soldado_muerto_hablado = true
		DialogueManager.show_dialogue_balloon(SoldadoMuerto, "start")

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false

	if dialogo_activo:
		sprite_2d_2.visible = false        # 📸 Foto desaparece
		desactivar_soldado()               # 🧹 NPC eliminado
		dialogo_activo = false

func desactivar_soldado():
	sprite_2d.visible = false
	sprite_2d_2.visible = false
	animated_sprite_2d.visible = false
	player_in_area = false

	for child in character_body_2d.get_children():
		if child is CollisionShape2D:
			child.disabled = true

	character_body_2d.set_physics_process(false)
	character_body_2d.set_process(false)
