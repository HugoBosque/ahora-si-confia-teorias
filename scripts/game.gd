extends Node

@onready var cura: Area2D = $Cura
@onready var door_to_church: Area2D = $DoorToChurch
@onready var player: CharacterBody2D = $Player

func _ready():
	# Conecta la señal de cambio de día
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_presencia_cura()

	# Conectar la señal de la puerta solo si el nodo existe
	if door_to_church:
		door_to_church.connect("body_entered", Callable(self, "_on_door_body_entered"))
	else:
		print("ERROR: door_to_church es null. Revisa el nombre del nodo.")

func _on_dia_cambiado(nuevo_dia: int):
	_actualizar_presencia_cura()

func _actualizar_presencia_cura():
	# Si la preocupación del cura es baja (< 50), está en el pueblo
	var activo = GameManager.preocupacion_cura < 50

	# 🔹 Visibilidad
	cura.visible = activo

	# 🔹 Activar/desactivar Area2D
	cura.set_deferred("monitoring", activo)
	cura.set_deferred("monitorable", activo)

	# 🔹 Desactivar todos los CollisionShape2D dentro del Area2D y del CharacterBody2D
	for child in cura.get_children():
		if child is CollisionShape2D:
			child.disabled = not activo
		if child is CharacterBody2D:
			for grandchild in child.get_children():
				if grandchild is CollisionShape2D:
					grandchild.disabled = not activo

# 🔹 Detectar cuando el jugador toca la puerta
func _on_door_body_entered(body: Node):
	if body == player:
		# Bloquear al jugador mientras cambiamos de escena
		GameManager.is_dialogue_active = true
		# Cambiar a la escena de la iglesia
		get_tree().change_scene_to_file("res://scenes/Iglesia.tscn")
