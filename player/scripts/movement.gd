class_name Player
extends CharacterBody2D

@export var move_speed: float = 200.0

var direction: Vector2 = Vector2.ZERO
var cardinal_direction: Vector2 = Vector2.DOWN
var state: String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# --- 1️⃣ Leer input ---
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	# --- 2️⃣ Normalizar y mover ---
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		cardinal_direction = get_cardinal_direction(direction)
		state = "walk"
	else:
		state = "idle"

	velocity = direction * move_speed
	move_and_slide()

	# --- 3️⃣ Actualizar animación ---
	update_animation()

func get_cardinal_direction(dir: Vector2) -> Vector2:
	# Detecta la dirección principal según el vector de movimiento
	if abs(dir.x) > abs(dir.y):
		return Vector2.RIGHT if dir.x > 0 else Vector2.LEFT
	else:
		return Vector2.DOWN if dir.y > 0 else Vector2.UP

func update_animation() -> void:
	var anim_name = state + "_" + anim_direction()
	if not animation_player.is_playing() or animation_player.current_animation != anim_name:
		animation_player.play(anim_name)

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	return "down" # valor por defecto
