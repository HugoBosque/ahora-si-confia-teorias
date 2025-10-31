extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const MIKHAIL_DIA_1_1 = preload("uid://buvoybyeof2ym")
const MIKHAIL_DIA_1_2 = preload("uid://sun5ej4wl11x")
const MIKHAIL_DIA_2_1 = preload("uid://c8y7142mc01p1")
const MIKHAIL_DIA_2_2 = preload("uid://bmf2lwbswweuu")
const MIKHAIL_DIA_3_1 = preload("uid://cjb4n2h64fgq5")
const MIKHAIL_DIA_3_2 = preload("uid://bg2otvj6xhwww")
const MIKHAIL_DIA_4_1 = preload("uid://dldw7nu3nxdqd")
const MIKHAIL_DIA_4_2 = preload("uid://dvpeewqdb5cso")
const MIKHAIL_DIA_5_1 = preload("uid://bsablhwsj8aa4")
const MIKHAIL_DIA_5_2 = preload("uid://qv150t1x3ipn")
const MIKHAIL_DIA_6_1 = preload("uid://cu3fgflephau0")
const MIKHAIL_DIA_6_2 = preload("uid://jerwqhjgxonl")
const MIKHAIL_DIA_7_1 = preload("uid://ilf0msyq8fft")
const MIKHAIL_DIA_7_2 = preload("uid://dhva7f56c6i5s")




var player_close: bool = false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_1_1, "start")
			elif Global.dia1_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_1_2, "start")
		elif GameManager.dia == 2:
			if not Global.dia2_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_2_1, "start")
			elif Global.dia2_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_2_2, "start")
		elif GameManager.dia == 3:
			if not Global.dia3_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_3_1, "start")
			elif Global.dia3_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_3_2, "start")
		elif GameManager.dia == 4:
			if not Global.dia4_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_4_1, "start")
			elif Global.dia4_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_4_2, "start")
		elif GameManager.dia == 5:
			if not Global.dia5_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_5_1, "start")
			elif Global.dia5_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_5_2, "start")
		elif GameManager.dia == 6:
			if not Global.dia6_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_6_1, "start")
			elif Global.dia6_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_6_2, "start")
		elif GameManager.dia == 7:
			if not Global.dia7_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_7_1, "start")
			elif Global.dia7_hablar_mikhail:
				DialogueManager.show_dialogue_balloon(MIKHAIL_DIA_7_2, "start")


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
