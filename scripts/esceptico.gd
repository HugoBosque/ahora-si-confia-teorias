extends Node2D

const ESCPETICO = preload("uid://c8t7n2okg0gjt")
@onready var sprite_2d: Sprite2D = $Sprite2D
const ESCEPTICO_DIA_1_2 = preload("uid://cdfwne4l8kh1")



var player_close: bool = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if not Global.dia1_halbar_esceptico: 
			DialogueManager.show_dialogue_balloon(ESCPETICO, "start")
		elif Global.dia1_halbar_esceptico:
			DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_1_2, "start")
		
		
		
func _on_area_entered(area):
	sprite_2d.visible = true
	player_close = true

func _on_area_exited(area):
	sprite_2d.visible = false
	player_close = false

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
