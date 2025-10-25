extends Node2D

@onready var tendero_plis_funciona: Area2D = $"tendero plis funciona"
@onready var animated_sprite_2d: Area2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if GameManager.preocupacion_cura >= 50:
		tendero_plis_funciona.visible = true
		animated_sprite_2d.visible = false
	elif GameManager.preocupacion_cura < 50:
		animated_sprite_2d.visible = true
		tendero_plis_funciona.visible = false
