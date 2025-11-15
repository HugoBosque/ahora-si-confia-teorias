extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var footsteps: AudioStreamPlayer2D = $Footsteps

var speed = 200.0
var last_direction = "down"

# Rutas a tus audios
var snow_audio = "res://AUDIO JUEGO/footsteps-in-thin-snow-46199.mp3"
var house_audio = "res://AUDIO JUEGO/pasos-steps-40285.mp3"
var cave_audio = "res://AUDIO JUEGO/person-walking-on-rocks-and-sand-100586.mp3"

func _ready():
	# Inicializa las variables de diálogo para evitar que el jugador quede bloqueado
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false
	_set_footsteps_audio()  # Establece el audio correcto según la escena

func _physics_process(delta):
	# Verificación adicional para asegurar que no esté en menú principal
	var current_scene = get_tree().current_scene
	if current_scene and ("menu" in str(current_scene.name).to_lower() or "Menu" in str(current_scene.name)):
		return

	if GameManager.is_dialogue_active or Global.is_game_paused:
		velocity = Vector2.ZERO        # 🔒 Detiene cualquier movimiento
		move_and_slide()               # 🔒 Aplica el freno inmediatamente
		if footsteps and footsteps.playing:
			footsteps.stop()           # Detener audio si hay diálogo o pausa
		return

	get_input()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction == Vector2.ZERO:
		velocity = Vector2.ZERO
		update_animation("idle")
		if footsteps and footsteps.playing:
			footsteps.stop()           # Detener audio cuando está quieto
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

	if footsteps and not footsteps.playing:
		footsteps.play()               # Reproducir audio cuando se mueve

func update_animation(state):
	animated_sprite.play(state + "_" + last_direction)

func set_movement_enabled(enabled: bool):
	GameManager.is_dialogue_active = not enabled

# Función para asignar el audio correcto según la escena
func _set_footsteps_audio():
	var scene_name = str(get_tree().current_scene.name).to_lower()
	if "game" in scene_name:
		footsteps.stream = load(snow_audio)
		footsteps.pitch_scale = 0.9   # pasos más lentos en la nieve
	elif "house" in scene_name or "iglesia" in scene_name:
		footsteps.stream = load(house_audio)
		footsteps.pitch_scale = 1.2   # velocidad normal
	elif "cueva" in scene_name:
		footsteps.stream = load(cave_audio)
		footsteps.pitch_scale = 1.4   # velocidad normal
	else:
		footsteps.stream = load(snow_audio)  # audio por defecto
		footsteps.pitch_scale = 1.2
