extends Node2D

const CURA = preload("uid://rfms3hm7305p")
@onready var sprite_2d_2: Sprite2D = $Sprite2D2

const TENDERO_PRIMERA = preload("uid://fq2m2hhvfcna")

var player_close: bool = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		DialogueManager.show_dialogue_balloon(TENDERO_PRIMERA, "start")
		


func _on_area_entered(area):
	sprite_2d_2.visible = true
	player_close = true

func _on_area_exited(area):
	sprite_2d_2.visible = false
	player_close = false

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
