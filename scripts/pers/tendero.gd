extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D



const TENDERO_DIA_1_1 = preload("uid://c3bucf5jcfqje")
const TENDERO_DIA_1_2 = preload("uid://rwv52mc8baj0")
const TENDERO_DIA_2_1 = preload("uid://jnthx2tkmqb8")
const TENDERO_DIA_2_2 = preload("uid://l6qnnwl2hyda")
const TENDERO_DIA_3_1 = preload("uid://thgxpuad1ug2")
const TENDERO_DIA_3_2 = preload("uid://cyyl04sfm6oqf")
const TENDERO_DIA_4_1 = preload("uid://nxi3rake2woi")
const TENDERO_DIA_4_2 = preload("uid://bbjiliajteoqi")
const TENDERO_DIA_5_1 = preload("uid://fnh3lcjbqiqa")
const TENDERO_DIA_5_2 = preload("uid://bpy8nin517vht")
const TENDERO_DIA_6_1 = preload("uid://xb1hm257nbls")
const TENDERO_DIA_6_2 = preload("uid://d2obgmvy0vin6")
const TENDERO_DIA_7_1 = preload("uid://e0nvky48tdyk")
const TENDERO_DIA_7_2 = preload("uid://wts1krlrm3qi")



var player_close: bool = false

func _ready() -> void:
	sprite_2d.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_1_1, "start")
			elif Global.dia1_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_2_1, "start")
			elif Global.dia2_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_3_1, "start")
			elif Global.dia3_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_4_1, "start")
			elif Global.dia4_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_5_1, "start")
			elif Global.dia5_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_6_1, "start")
			elif Global.dia6_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_7_1, "start")
			elif Global.dia7_hablar_tendero:
				DialogueManager.show_dialogue_balloon(TENDERO_DIA_7_2, "start")


func _on_area_entered(area: Area2D) -> void:
	sprite_2d.visible = true
	player_close = true

func _on_area_exited(area: Area2D) -> void:
	sprite_2d.visible = false
	player_close = false

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
