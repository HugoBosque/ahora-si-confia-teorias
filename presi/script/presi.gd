extends Node2D

var player_near = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":  # Cambia según el nombre real del jugador
		player_near = true
		DialogueManager3.start_dialog("npc1_intro")  # Reemplaza con el ID de tu diálogo

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_near = false
