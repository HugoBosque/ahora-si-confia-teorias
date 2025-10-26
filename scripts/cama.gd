extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion




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
		if GameManager.dia == 1:
			get_tree().change_scene_to_file("res://scenes/dias/dia_3.tscn")
		elif GameManager.dia == 2:
			get_tree().change_scene_to_file("res://scenes/dias/dia_4.tscn")

		GameManager.cambiar_dia()  # <-- ahora usamos la función del GameManager
