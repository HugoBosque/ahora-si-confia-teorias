extends Node2D

const ESCPETICO = preload("uid://c8t7n2okg0gjt")
@onready var sprite_2d: Sprite2D = $Sprite2D
const ESCEPTICO_DIA_1_2 = preload("uid://cdfwne4l8kh1")
const ESCEPTICO_DIA_2_1 = preload("uid://dmgqdfjsokwlm")
const ESCEPTICO_DIA_2_2 = preload("uid://cxbmvxdvpiov2")
const ESCEPTICO_DIA_3_1 = preload("uid://o8twq6u6drgq")
const ESCEPTICO_DIA_3_2 = preload("uid://04mi037i6xk7")
const ESCEPTICO_DIA_4_1 = preload("uid://t38u7klult1l")
const ESCEPTICO_DIA_4_2 = preload("uid://ba2mdxi6vdexo")
const ESCEPTICO_DIA_5_1 = preload("uid://c0hnxvcni1q03")
const ESCEPTICO_DIA_5_2 = preload("uid://c7t7pwxs6t3an")
const ESCEPTICO_DIA_6_1 = preload("uid://b3d5iahwit5uf")
const ESCEPTICO_DIA_6_2 = preload("uid://02kyeg0avacm")
const ESCEPTICO_DIA_7_1 = preload("uid://bckkqwxn7ktj5")
const ESCEPTICO_DIA_7_2 = preload("uid://c483t8mwvj478")



var player_close: bool = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCPETICO, "start")
			elif Global.dia1_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_1_2, "start")
		if GameManager.dia == 2:
			if not Global.dia2_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_2_1, "start")
			elif Global.dia2_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_2_2, "start")
		if GameManager.dia == 3:
			if not Global.dia3_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_3_1, "start")
			elif Global.dia3_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_3_2, "start")
		if GameManager.dia == 4:
			if not Global.dia4_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_4_1, "start")
			elif Global.dia4_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_4_2, "start")
		if GameManager.dia == 5:
			if not Global.dia5_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_5_1, "start")
			elif Global.dia5_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_5_2, "start")
		if GameManager.dia == 6:
			if not Global.dia6_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_6_1, "start")
			elif Global.dia6_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_6_2, "start")
		if GameManager.dia == 7:
			if not Global.dia7_halbar_esceptico: 
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_7_1, "start")
			elif Global.dia7_halbar_esceptico:
				DialogueManager.show_dialogue_balloon(ESCEPTICO_DIA_7_2, "start")


		
		
		
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
