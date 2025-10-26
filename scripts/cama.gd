extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion

const ESTADISTICAS_DIA = preload("res://scenes/cinemarografia/Estadisticas_Dia.tscn")

var player_in_area = false

func _ready():
	exclamacion.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true
		exclamacion.visible = true

func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		exclamacion.visible = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		GameManager.cambiar_dia()  # <-- ahora usamos la función del GameManager
