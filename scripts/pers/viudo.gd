extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const VIUDO_DIA_1_1 = preload("uid://bufhg6d5aydkn")
const VIUDO_DIA_1_2 = preload("uid://booo1ytiktf2v")
const VIUDO_DIA_2_1 = preload("uid://cjsgrhwp5w8hg")
const VIUDO_DIA_2_2 = preload("uid://c74v8n0s2e8dr")
const VIUDO_DIA_3_1 = preload("uid://dieglkwdx7yba")
const VIUDO_DIA_3_2 = preload("uid://bkfo0c74583yv")
const VIUDO_DIA_4_1 = preload("uid://drcry1q38van2")
const VIUDO_DIA_4_2 = preload("uid://cdu0e62lq8u3p")
const VIUDO_DIA_5_1 = preload("uid://cda56j8w6wwir")
const VIUDO_DIA_5_2 = preload("uid://jhxrqxeb8gd4")
const VIUDO_DIA_6_1 = preload("uid://dyn3taevc7g8q")
const VIUDO_DIA_6_2 = preload("uid://bswq6vna3pgaw")
const VIUDO_DIA_7_1 = preload("uid://cbud7h1dqdk3g")
const VIUDO_DIA_7_2 = preload("uid://cupo1xlulh7pg")



var player_close: bool = false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_1_1, "start")
			elif Global.dia1_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_2_1, "start")
			elif Global.dia2_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_3_1, "start")
			elif Global.dia3_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_4_1, "start")
			elif Global.dia4_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_5_1, "start")
			elif Global.dia5_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_6_1, "start")
			elif Global.dia6_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_7_1, "start")
			elif Global.dia7_hablar_viudo:
				DialogueManager.show_dialogue_balloon(VIUDO_DIA_7_2, "start")


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
