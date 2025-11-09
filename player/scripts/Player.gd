extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

var speed = 200.0
var last_direction = "down"

func _ready():
	# Inicializa las variables de diálogo para evitar que el jugador quede bloqueado
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false

func _physics_process(delta):
	# Verificación adicional para asegurar que no esté en menú principal
	var current_scene = get_tree().current_scene
	if current_scene and ("menu" in current_scene.name or "Menu" in current_scene.name):
		return
		
	if GameManager.is_dialogue_active or Global.is_game_paused:
		velocity = Vector2.ZERO        # 🔒 Detiene cualquier movimiento
		move_and_slide()               # 🔒 Aplica el freno inmediatamente
		return

	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
		update_animation("idle")
		return
	
	if abs(input_direction.x) > abs(input_direction.y):
		if input_direction.x > 0:
			last_direction = "right"
		else:
			last_direction = "left"
	else:
		if input_direction.y > 0:
			last_direction = "down"
		else:
			last_direction = "up"
			
	update_animation("walk")
	
	velocity = input_direction * speed

func update_animation(state):
	animated_sprite.play(state + "_" + last_direction)

func set_movement_enabled(enabled: bool):
	GameManager.is_dialogue_active = not enabled
