extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion


# @onready var pantalla_resumen = preload("res://ui/PantallaResumenDia.tscn")

var player_in_area = false




func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true
		exclamacion.visible = true


func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false
		exclamacion.visible = false
		
func _ready():
	exclamacion.visible = false


func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		GameManager.dia += 1
		#_dormir()

# func _dormir():
	#var player = get_parent().get_node_or_null("Player")
	#if player:
		#player.set_movement_enabled(false)

#	var resumen = pantalla_resumen.instantiate()
#	get_tree().get_root().add_child(resumen)
