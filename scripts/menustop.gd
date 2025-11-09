extends CanvasLayer

@onready var continuar_button: Button = $VBoxContainer/Continuar
@onready var salir_button: Button = $VBoxContainer/Salir

var is_paused: bool = false

func _ready():
	visible = false
	Global.pause_menu_controller = self
	
	# Conectar botones
	continuar_button.pressed.connect(_on_continuar_pressed)
	salir_button.pressed.connect(_on_salir_pressed)

func toggle_pause_menu():
	if is_paused:
		_resume_game()
	else:
		_pause_game()

func _pause_game():
	visible = true
	is_paused = true
	Global.is_game_paused = true   # ❌ Bloquea el movimiento del jugador
	# No usamos get_tree().paused

func _resume_game():
	visible = false
	is_paused = false
	Global.is_game_paused = false
	get_tree().paused = false  # Asegurar que el árbol no esté pausado

func _on_continuar_pressed():
	_resume_game()

func _on_salir_pressed():
	Global.save_game()
	Global.is_game_paused = false  # Resetear antes de cambiar escena
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
