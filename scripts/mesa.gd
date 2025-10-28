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

func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("ui_accept") and GameManager.has_done_cinematic1:
		_on_click()
		
func _on_click() -> void:
	if GameManager.dia == 1:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia1/dia_1a.tscn")
	elif GameManager.dia == 2:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia2/dia_2a.tscn")
	elif GameManager.dia == 3:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia3/dia_3a.tscn")
	elif GameManager.dia == 4:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia4/dia_4a.tscn")
	elif GameManager.dia == 5:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia5/dia_5a.tscn")
	elif GameManager.dia == 6:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia6/dia_6a.tscn")
	elif GameManager.dia == 7:
		get_tree().change_scene_to_file("res://scenes/dias/periodicos/dia7/dia_7a.tscn")
	
