extends Control

# Precargamos las escenas del juego (ajusta las rutas según tu proyecto)
@onready var house_scene = preload("res://scenes/House.tscn")
@onready var town_scene = preload("res://scenes/game.tscn")

# Botones
@onready var play_button = $Play
@onready var continuar_button = $Continuar
@onready var salir_button = $Salir

func _ready() -> void:
	# Conectar botones
	play_button.pressed.connect(_on_play_pressed)
	continuar_button.pressed.connect(_on_continuar_pressed)
	salir_button.pressed.connect(_on_salir_pressed)

	# Resetear estado global básico al cargar el menú
	Global.reset_game_state()
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false

	# Comprobar si existe partida guardada
	if Global.load_game():
		print("✅ Partida anterior cargada.")
	else:
		print("🌱 No se encontró partida guardada.")

# --- BOTONES ---

func _on_play_pressed() -> void:
	# ================= NUEVA PARTIDA =================
	Global.reset_full_game()

	# Reset total del GameManager
	for prop in GameManager.get_property_list():
		if prop.name == "script":
			continue

		var value = GameManager.get(prop.name)
		if value is bool:
			GameManager.set(prop.name, false)
		elif value is int:
			GameManager.set(prop.name, 0)

	# Valores iniciales reales del GameManager
	GameManager.dia = 1

	GameManager.vida_cura = 100
	GameManager.vida_esceptico = 100
	GameManager.vida_madre = 100
	GameManager.vida_viktor = 100
	GameManager.vida_viudo = 100
	GameManager.vida_medico = 100
	GameManager.vida_nina = 100
	GameManager.vida_mikhail = 100
	GameManager.vida_tendero = 100
	GameManager.vida_yerik = 100

	GameManager.preocupacion_cura = 0
	GameManager.preocupacion_esceptico = 0
	GameManager.preocupacion_madre = 0
	GameManager.preocupacion_viktor = 0
	GameManager.preocupacion_viudo = 0
	GameManager.preocupacion_medico = 0
	GameManager.preocupacion_nina = 0
	GameManager.preocupacion_mikhail = 0
	GameManager.preocupacion_tendero = 0
	GameManager.preocupacion_yerik = 0

	GameManager.cura_en_iglesia = false
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false

	print("🌱 Nueva partida iniciada")

	get_tree().change_scene_to_packed(house_scene)


func _on_continuar_pressed() -> void:
	if not Global.load_game():
		print("⚠️ No hay partida guardada, empieza un juego nuevo.")
		return

	# Resetear estado técnico antes de cambiar de escena
	Global.reset_game_state()
	GameManager.is_dialogue_active = false
	GameManager.has_animation_done = false

	# Siempre empezar en House
	print("🏠 Cargando partida guardada - Iniciando en House.tscn (Día ", Global.dia, ")")
	get_tree().change_scene_to_packed(house_scene)


func _on_salir_pressed() -> void:
	Global.save_game()
	get_tree().quit()
