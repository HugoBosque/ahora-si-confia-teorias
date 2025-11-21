extends CanvasLayer

@onready var continuar_button: Button = $Continuar
@onready var salir_button: Button = $Salir
@onready var silenciar: Button = $Silenciar

# Iconos del botón silenciar
@onready var icon_volume_on = preload("res://imagenes/audio unmuted.png")
@onready var icon_volume_muted = preload("res://imagenes/audio muted blanco.png")

var is_paused: bool = false
var music_muted: bool = false  # Estado del muteo

func _ready():
	visible = false
	Global.pause_menu_controller = self
	
	# Conectar botones
	continuar_button.pressed.connect(_on_continuar_pressed)
	salir_button.pressed.connect(_on_salir_pressed)
	silenciar.pressed.connect(_on_silenciar_pressed)

	# Icono inicial
	silenciar.icon = icon_volume_on


# ------------------------------------------------
#                PAUSA / RESUME
# ------------------------------------------------
func toggle_pause_menu():
	if is_paused:
		_resume_game()
	else:
		_pause_game()

func _pause_game():
	visible = true
	is_paused = true
	Global.is_game_paused = true

func _resume_game():
	visible = false
	is_paused = false
	Global.is_game_paused = false
	get_tree().paused = false

func _on_continuar_pressed():
	_resume_game()

func _on_salir_pressed():
	Global.save_game()
	Global.is_game_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


# ------------------------------------------------
#        🎵 SILENCIAR TODA LA MÚSICA + ICONO
# ------------------------------------------------
func _on_silenciar_pressed():
	music_muted = !music_muted  # Cambiar estado

	# Cambiar icono del botón
	silenciar.icon = icon_volume_muted if music_muted else icon_volume_on

	# Buscar todos los AudioStreamPlayer del juego (si es la primera vez)
	var all_audio = get_tree().get_nodes_in_group("_all_audio_scan_")
	if all_audio.is_empty():
		_register_all_audio_players()
		all_audio = get_tree().get_nodes_in_group("_all_audio_scan_")

	# Mutear / Activar todos los AudioStreamPlayer
	for node in all_audio:
		if node is AudioStreamPlayer:
			node.stream_paused = music_muted


# ------------------------------------------------
#   🔍 Registrar todos los audios del juego
# ------------------------------------------------
func _register_all_audio_players():
	var root = get_tree().root
	_scan_audio_nodes(root)

func _scan_audio_nodes(node):
	if node is AudioStreamPlayer:
		node.add_to_group("_all_audio_scan_")

	for child in node.get_children():
		_scan_audio_nodes(child)
