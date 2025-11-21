extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const MEDICO_DIA_1_1 = preload("uid://dkh8f4klolknp")
const MEDICO_DIA_1_2 = preload("uid://bokd0fin85yry")
const MEDICO_DIA_2_1 = preload("uid://cv8pynfn14noj")
const MEDICO_DIA_2_2 = preload("uid://dgaaf8aro7lsi")
const MEDICO_DIA_3_1 = preload("uid://b2tdd72uhoo88")
const MEDICO_DIA_3_2 = preload("uid://dlfhogk4gj843")
const MEDICO_DIA_4_1 = preload("uid://cqihhdwbu7qap")
const MEDICO_DIA_4_2 = preload("uid://cgqisk0ninoq")
const MEDICO_DIA_5_1 = preload("uid://baqn0jk0ysomy")
const MEDICO_DIA_5_2 = preload("uid://ddi2kjphcu7m1")
const MEDICO_DIA_6_1 = preload("uid://c1vnhitu5lr44")
const MEDICO_DIA_6_2 = preload("uid://qr1imqrvw5b5")
const MEDICO_DIA_7_1 = preload("uid://bd8reuapj2sn7")
const MEDICO_DIA_7_2 = preload("uid://dxcusfqkjoxgq")


var player_close: bool = false

func _ready() -> void:
	sprite_2d.visible = false
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_1_1, "start")
			elif Global.dia1_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_2_1, "start")
			elif Global.dia2_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_3_1, "start")
			elif Global.dia3_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_4_1, "start")
			elif Global.dia4_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_5_1, "start")
			elif Global.dia5_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_6_1, "start")
			elif Global.dia6_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_7_1, "start")
			elif Global.dia7_hablar_medico:
				DialogueManager.show_dialogue_balloon(MEDICO_DIA_7_2, "start")


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
