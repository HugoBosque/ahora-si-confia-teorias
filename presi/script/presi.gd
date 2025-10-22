extends Node2D  # o Area2D si quieres, pero Node2D funciona bien

const MY_DIALOGUE = preload("res://Dialogue/my_dialogue.dialogue")
var has_talked = false

# Esta función debe conectarse a Area2D_Detect → area_entered
func _on_Area2D_Detect_area_entered(area):
	if area.is_in_group("Player") and not has_talked:
		has_talked = true
		DialogueManager.show_dialogue_balloon(MY_DIALOGUE, "start")

# Conectada a Area2D_Detect → area_exited
func _on_Area2D_Detect_area_exited(area):
	if area.is_in_group("Player"):
		has_talked = false
