extends Control

const HOUSE = preload("res://scenes/House.tscn")

func _ready() -> void:
	if $Continue:
		$Continue.pressed.connect(_on_continue_pressed)
	else:
		print("⚠️ No se encontró el botón Continue")

func _on_continue_pressed() -> void:
	print("▶ Cambiando a escena House...")
	get_tree().change_scene_to_packed(HOUSE)
