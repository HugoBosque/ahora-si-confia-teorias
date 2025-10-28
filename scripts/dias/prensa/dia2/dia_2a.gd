extends Control


@export var siguiente: String

@onready var seguir: Button = $seguir



func _ready() -> void:

	seguir.pressed.connect(_on_seguir_pressed)


func _on_seguir_pressed() -> void:
	get_tree().change_scene_to_file(siguiente)
