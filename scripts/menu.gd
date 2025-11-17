extends Control

# Precargamos las escenas del juego (ajusta las rutas según tu proyecto)
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")
const MENU_1 = preload("uid://b264ja6tthvh3")

# Botones
@onready var play_button = $Play
@onready var continuar_button = $Continuar
@onready var salir_button = $Salir

func _ready() -> void:
	# Conectar botones
	play_button.pressed.connect(_on_play_pressed)

	salir_button.pressed.connect(_on_salir_pressed)

	# Resetear estado global al cargar el menú
	Global.reset_game_state()
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false

	# Cargar partida al iniciar (solo para comprobar que existe)
	if Global.load_game():
		print("✅ Partida anterior cargada.")
	else:
		print("🌱 No se encontró partida guardada.")

# --- BOTONES ---
func _on_play_pressed() -> void:
	# Resetear estado antes de cambiar de escena
	Global.reset_game_state()
	GameManager.is_dialogue_active = false

	if not Global.game_saved:
		get_tree().change_scene_to_packed(house_scene)
	else:
		get_tree().change_scene_to_packed(MENU_1)



func _on_salir_pressed() -> void:
	Global.save_game()  # Guardar antes de salir
	get_tree().quit()
