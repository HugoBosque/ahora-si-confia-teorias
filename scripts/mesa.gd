extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2



var player_in_area = false

func _ready():
	exclamacion.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))


func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true
		exclamacion.visible = true


func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		exclamacion.visible = false
		sprite_2d.visible = false
		sprite_2d_2.visible = false
		
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		_on_click()
		
func _on_click() -> void:
	# Muestra una imagen u otra según el día
	if GameManager.dia == 1:
		sprite_2d.visible = true
		sprite_2d_2.visible = false
	elif GameManager.dia == 2:
		sprite_2d_2.visible = true
		sprite_2d.visible = false
	else:
		# Si quieres, puedes ocultarlas en otros días
		sprite_2d.visible = false
		sprite_2d_2.visible = false
