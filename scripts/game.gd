extends Node

@onready var cura: Area2D = $Cura
@onready var door_to_church: Area2D = $DoorToChurch  # Ajusta el nombre EXACTO de tu nodo en la escena
@onready var player: Node = $Player  # referencia al Player en la escena

func _ready():
	# Conecta la señal de cambio de día
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_presencia_cura()

	# 🔹 Conectar la señal de la puerta solo si el nodo existe
	if door_to_church:
		door_to_church.connect("body_entered", Callable(self, "_on_door_body_entered"))
	else:
		print("ERROR: door_to_church es null. Revisa el nombre del nodo.")

func _on_dia_cambiado(nuevo_dia: int):
	_actualizar_presencia_cura()

func _actualizar_presencia_cura():
	# Si la preocupación del cura es baja (< 50), está en el pueblo
	var activo = GameManager.preocupacion_cura < 50

	cura.visible = activo
	cura.set_deferred("monitoring", activo)
	cura.set_deferred("monitorable", activo)

	for shape in cura.get_children():
		if shape is CollisionShape2D:
			shape.disabled = not activo

# 🔹 Detectar cuando el jugador toca la puerta
func _on_door_body_entered(body: Node):
	if body == player:
		# Bloquear al jugador mientras cambiamos de escena
		GameManager.is_dialogue_active = true
		# Cambiar a la escena de la iglesia
		get_tree().change_scene_to_file("res://scenes/Iglesia.tscn")
