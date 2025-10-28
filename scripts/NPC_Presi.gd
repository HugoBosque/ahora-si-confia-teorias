extends Area2D

const MY_DIALOGUE = preload("uid://dqx4dn8r3g2br")

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var guardia_2: AnimatedSprite2D = $"../Guardia_2"
@onready var guardia_1: AnimatedSprite2D = $"../Guardia_1"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

var is_player_close = false
var is_dialogue_done = false

func _ready():
	# ⚙️ Si ya se hizo antes, ocultar todo y salir
	if GameManager.has_done_dialogue1:
		_hide_all_event_elements()
		return

	# Si es la primera vez, conectar señales
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	animation_player.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	# Mostrar el diálogo solo si el jugador está cerca y aún no se hizo
	if is_player_close and not GameManager.is_dialogue_active and not is_dialogue_done:
		DialogueManager.show_dialogue_balloon(MY_DIALOGUE, "start")
		is_dialogue_done = true

func _on_area_entered(area):
	if not is_dialogue_done:
		is_player_close = true

func _on_area_exited(area: Area2D) -> void:
	is_player_close = false

func _on_dialogue_ended(dialogue):
	print("🎭 Diálogo TERMINADO - Preparando animación")
	await get_tree().create_timer(0.2).timeout
	animation_player.play("acto1")

func _on_animation_finished(anim_name: String):
	print("🎭 Animación TERMINADA: ", anim_name)
	if anim_name == "acto1":
		_hide_all_event_elements()
		GameManager.has_done_dialogue1 = true

func _hide_all_event_elements():
	# Oculta todos los elementos relacionados con el evento
	guardia_1.visible = false
	guardia_2.visible = false
	animated_sprite_2d.visible = false
	visible = false # Oculta el Area2D si tiene forma o sprite

	# Desactivar detección de colisiones
	monitoring = false
	set_deferred("monitorable", false)
