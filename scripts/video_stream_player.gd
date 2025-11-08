extends Control

@onready var video: VideoStreamPlayer = $VideoStreamPlayer


func _ready():
	video.play()
	video.connect("finished", Callable(self, "_on_video_finished"))

func _on_video_finished():
	# Cuando el video termina, pasamos al siguiente día
	if GameManager.dia == 1:
		get_tree().change_scene_to_file("res://scenes/dias/dia_1.tscn")
	elif GameManager.dia == 2:
		get_tree().change_scene_to_file("res://scenes/dias/dia_2.tscn")
	elif GameManager.dia == 3:
		get_tree().change_scene_to_file("res://scenes/dias/dia_3.tscn")
	elif GameManager.dia == 4:
		get_tree().change_scene_to_file("res://scenes/dias/dia_4.tscn")
	elif GameManager.dia == 5:
		get_tree().change_scene_to_file("res://scenes/dias/dia_5.tscn")
	elif GameManager.dia == 6:
		get_tree().change_scene_to_file("res://scenes/dias/dia_6.tscn")
	elif GameManager.dia == 7:
		get_tree().change_scene_to_file("res://scenes/dias/dia_7.tscn")

	GameManager.cambiar_dia()
