extends Node2D

const MADRE = preload("uid://dmkgn5v5rlukt")
@onready var sprite_2d: Sprite2D = $Sprite2D
const MADRE_DIA_1_2 = preload("uid://dsg7k0ygjhpmg")
const MADRE_DIA_2_1 = preload("uid://d4g5mkdrm0mgp")
const MADRE_DIA_2_2 = preload("uid://d1j8aaaygmwo4")
const MADRE_DIA_3_1 = preload("uid://btx4j7k1xpngk")
const MADRE_DIA_3_2 = preload("uid://crqlak5ndvw7k")
const MADRE_DIA_4_1 = preload("uid://bi1egvkia1uc3")
const MADRE_DIA_4_2 = preload("uid://beh3gatmmxt54")
const MADRE_DIA_5_1 = preload("uid://dgq0uh512qa10")
const MADRE_DIA_5_2 = preload("uid://1h7eyduegt1j")
const MADRE_DIA_6_1 = preload("uid://d3trvtqjyb5bi")
const MADRE_DIA_6_2 = preload("uid://cbxyeb565jiqq")
const MADRE_DIA_7_1 = preload("uid://ch6ypvtu2j8sc")
const MADRE_DIA_7_2 = preload("uid://h73vmlalpq3t")
const MADRE_IGLESIA_2_2 = preload("uid://bmampj780cdh0")
const MADRE_IGLESIA_2_1 = preload("uid://ccy70xj2jnqse")




var player_close: bool = false


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
	
func _process(delta):
	if player_close and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active:
		if GameManager.dia == 1:
			if not Global.dia1_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE, "start")
			elif Global.dia1_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_1_2, "start")
		if GameManager.dia == 2:
			if not Global.dia2_madre_noticia1:
				if not Global.dia2_hablar_madre:
					DialogueManager.show_dialogue_balloon(MADRE_DIA_2_1, "start")
				elif Global.dia2_hablar_madre:
					DialogueManager.show_dialogue_balloon(MADRE_DIA_2_2, "start")
			elif Global.dia2_madre_noticia1:
				if not Global.dia2_hablar_madre:
					DialogueManager.show_dialogue_balloon(MADRE_IGLESIA_2_1, "start")
				elif Global.dia2_hablar_madre:
					DialogueManager.show_dialogue_balloon(MADRE_IGLESIA_2_2, "start")
		if GameManager.dia == 3:
			if not Global.dia3_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_3_1, "start")
			elif Global.dia3_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_3_2, "start")
		if GameManager.dia == 4:
			if not Global.dia4_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_4_1, "start")
			elif Global.dia4_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_4_2, "start")
		if GameManager.dia == 5:
			if not Global.dia5_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_5_1, "start")
			elif Global.dia5_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_5_2, "start")
		if GameManager.dia == 6:
			if not Global.dia6_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_6_1, "start")
			elif Global.dia6_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_6_2, "start")
		if GameManager.dia == 7:
			if not Global.dia7_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_7_1, "start")
			elif Global.dia7_hablar_madre:
				DialogueManager.show_dialogue_balloon(MADRE_DIA_7_2, "start")
		
		
		
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
