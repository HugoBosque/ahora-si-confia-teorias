extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const YERIK_DIA_1_1 = preload("uid://lvjvxm0mqgyh")
const YERIK_DIA_1_2 = preload("uid://cewsl2o358ddt")
const YERIK_DIA_2_1 = preload("uid://cetmwkjo7tj11")
const YERIK_DIA_2_2 = preload("uid://cgud6e8dhwued")
const YERIK_DIA_3_1 = preload("uid://bfprlg4ihermo")
const YERIK_DIA_3_2 = preload("uid://d1qwspfuhvdb3")
const YERIK_DIA_4_1 = preload("uid://orojqtrc5gsv")
const YERIK_DIA_4_2 = preload("uid://tks2gdmpdovf")
const YERIK_DIA_5_1 = preload("uid://cct0p3lttordi")
const YERIK_DIA_5_2 = preload("uid://cr1ehdc05b3vd")
const YERIK_DIA_6_1 = preload("uid://b1jovwl8ro4dx")
const YERIK_DIA_6_2 = preload("uid://i5wq75o3gons")
const YERIK_DIA_7_1 = preload("uid://mmp7nvs7vk3y")
const YERIK_DIA_7_2 = preload("uid://lyfsd8cgiwpn")



var player_close: bool = false

func _ready() -> void:
	sprite_2d.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_1_1, "start")
			elif Global.dia1_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_2_1, "start")
			elif Global.dia2_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_3_1, "start")
			elif Global.dia3_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_4_1, "start")
			elif Global.dia4_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_5_1, "start")
			elif Global.dia5_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_6_1, "start")
			elif Global.dia6_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_7_1, "start")
			elif Global.dia7_hablar_yerik:
				DialogueManager.show_dialogue_balloon(YERIK_DIA_7_2, "start")


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
