extends Node2D

func _ready():
	DialogueManager.show_dialogue_balloon(preload("res://Dialogue/my_dialogue.dialogue"), "start")
