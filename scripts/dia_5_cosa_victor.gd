extends Area2D


@onready var sprite_2d: Sprite2D = $Sprite2D

var player_in_area = false

func _ready():
	sprite_2d.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true
		sprite_2d.visible = true


func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		sprite_2d.visible = false


func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("accept") and GameManager.dia == 5:
		print("vicniga")
