extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const VIKTOR_DIA_1_1 = preload("uid://br1pk6yiob0ce")
const VIKTOR_DIA_1_2 = preload("uid://mm6qcuy5d2n5")
const VIKTOR_DIA_2_1 = preload("uid://iowsivbplupg")
const VIKTOR_DIA_2_2 = preload("uid://dae6fgr7t7yin")
const VIKTOR_DIA_3_1 = preload("uid://l66qw6nv5f0")
const VIKTOR_DIA_3_2 = preload("uid://busq5h8vvxlke")
const VIKTOR_DIA_4_1 = preload("uid://bgp1c0scphbj8")
const VIKTOR_DIA_4_2 = preload("uid://ei60plaamaik")
const VIKTOR_DIA_5_1 = preload("uid://bgbsaiv1r1lf6")
const VIKTOR_DIA_5_2 = preload("uid://be047tprpg2fl")
const VIKTOR_DIA_6_1 = preload("uid://dneetc5f636fh")
const VIKTOR_DIA_6_2 = preload("uid://cnoahr4qmk84")
const VIKTOR_DIA_7_1 = preload("uid://d4ewo6bsxxbxu")
const VIKTOR_DIA_7_2 = preload("uid://cpse1d2raakoa")


var player_close: bool = false

func _ready() -> void:
	sprite_2d.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_1_1, "start")
			elif Global.dia1_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_2_1, "start")
			elif Global.dia2_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_3_1, "start")
			elif Global.dia3_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_4_1, "start")
			elif Global.dia4_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_5_1, "start")
			elif Global.dia5_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_6_1, "start")
			elif Global.dia6_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_7_1, "start")
			elif Global.dia7_hablar_Viktor:
				DialogueManager.show_dialogue_balloon(VIKTOR_DIA_7_2, "start")


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
