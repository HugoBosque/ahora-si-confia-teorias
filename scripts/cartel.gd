extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion

const DIA_4_ALL = preload("uid://mpgrj23dxrgk")

var player_in_area = false
var dialogue_talked = false
func _ready():
	exclamacion.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true
		exclamacion.visible = true

func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		exclamacion.visible = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept") and not GameManager.is_dialogue_active and not dialogue_talked:
		DialogueManager.show_dialogue_balloon(DIA_4_ALL, "start")
		dialogue_talked = true

func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
