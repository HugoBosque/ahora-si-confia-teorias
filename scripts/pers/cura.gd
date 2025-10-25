extends Node2D



const CURA = preload("uid://rfms3hm7305p")
const TENDERO_PRIMERA = preload("uid://fq2m2hhvfcna")



var player_close: bool = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			DialogueManager.show_dialogue_balloon(CURA, "start")
		elif GameManager.dia == 2:
			DialogueManager.show_dialogue_balloon(TENDERO_PRIMERA, "start")
		
		
		

func _on_area_entered(area):
	player_close = true

func _on_area_exited(area):
	player_close = false

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
