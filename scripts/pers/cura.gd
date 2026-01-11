extends Node2D



const CURA = preload("uid://rfms3hm7305p")

@onready var sprite_2d: Sprite2D = $Sprite2D
const CURA_DIA_1_2 = preload("uid://0dekmcfgvtm5")
const CURA_DIA_2_1 = preload("uid://hfir1vwpb8ef")
const CURA_DIA_2_2 = preload("uid://1mx04wfh2v2h")
const CURA_DIA_3_1 = preload("uid://ce3gpwic0b5ut")
const CURA_DIA_3_2 = preload("uid://cbs8rkik4t8e6")
const CURA_DIA_4_1 = preload("uid://crx0rv2wrgjf4")
const CURA_DIA_4_2 = preload("uid://b1m3h6svv4ar7")
const CURA_DIA_5_1 = preload("uid://cf470e8opb8rp")
const CURA_DIA_5_2 = preload("uid://ce665eesq5osg")
const CURA_DIA_6_1 = preload("uid://0tw1ckq638dq")
const CURA_DIA_6_2 = preload("uid://bu2if7j5hki77")
const CURA_DIA_7_1 = preload("uid://co5g0yosa37vl")
const CURA_DIA_7_2 = preload("uid://da7nvowrjm0vq")



var player_close: bool = false


func _ready() -> void:
	sprite_2d.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA, "start")
			elif Global.dia1_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_2_1, "start")
			elif Global.dia2_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_3_1, "start")
			elif Global.dia3_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_3_2, "start")
#		elif GameManager.dia == 4:
#			if not Global.dia4_hablar_cura:
#				DialogueManager.show_dialogue_balloon(CURA_DIA_4_1, "start")
#			elif Global.dia4_hablar_cura:
#				DialogueManager.show_dialogue_balloon(CURA_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_5_1, "start")
			elif Global.dia5_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_6_1, "start")
			elif Global.dia6_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_7_1, "start")
			elif Global.dia7_hablar_cura:
				DialogueManager.show_dialogue_balloon(CURA_DIA_7_2, "start")
		
		

func _on_area_entered(area):
	if not GameManager.dia == 4:
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
