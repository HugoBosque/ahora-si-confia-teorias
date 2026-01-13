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

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("accept") and GameManager.has_done_cinematic1:
		# Cargar la escena del video
		GameManager.comprobar_vidas()
		get_tree().change_scene_to_file("res://scenes/cinemarografia/video_stream_player.tscn")
