extends Node2D

@onready var area = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var player_in_range = false

func _ready():
	# Oculta el signo de exclamación al iniciar
	sprite_2d.visible = false
	# Conecta las señales del área
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"): # Asegúrate de que el jugador tenga este grupo
		player_in_range = true
		sprite_2d.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		sprite_2d.visible = false
