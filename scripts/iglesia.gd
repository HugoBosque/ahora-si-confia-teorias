extends Node

@onready var cura: Area2D = $Cura

func _ready():
	# Escuchamos el cambio de día
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_presencia_cura()

func _on_dia_cambiado(nuevo_dia: int):
	_actualizar_presencia_cura()

func _actualizar_presencia_cura():
	# Si la preocupación del cura es alta (>= 50), está en la iglesia
	var activo = GameManager.preocupacion_cura >= 50

	cura.visible = activo
	cura.set_deferred("monitoring", activo)   # Desactiva la detección de colisiones del Area2D
	cura.set_deferred("monitorable", activo)  # Evita que otros nodos detecten su colisión

	# Si el cura tiene colisiones hijas (CollisionShape2D o CollisionPolygon2D), las desactivamos también
	for shape in cura.get_children():
		if shape is CollisionShape2D:
			shape.disabled = not activo
