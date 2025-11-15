extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const TENDERO_DIA_1_1 = preload("uid://c3bucf5jcfqje")
const YERIK_DIA_1_1 = preload("uid://lvjvxm0mqgyh")

var player_close: bool = false



func _process(delta: float) -> void:
	if player_close and Input.is_action_just_pressed("accept"):
		DialogueManager.show_dialogue_balloon(YERIK_DIA_1_1, "start")

func _on_area_entered(area: Area2D) -> void:
	sprite_2d.visible = true
	player_close = true


func _on_area_exited(area: Area2D) -> void:
	sprite_2d.visible = false
	player_close = false
