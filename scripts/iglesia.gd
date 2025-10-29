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

	# 🔹 Mostrar/ocultar el cura
	cura.visible = activo
	cura.set_deferred("monitoring", activo)   # Desactiva la detección de colisiones del Area2D
	cura.set_deferred("monitorable", activo)  # Evita que otros nodos detecten su colisión

	# 🔹 Desactivar todas las colisiones dentro del nodo Cura, sin importar el nivel
	_desactivar_colisiones_recursivo(cura, not activo)

# Función recursiva para desactivar CollisionShape2D y CollisionPolygon2D
func _desactivar_colisiones_recursivo(node: Node, desactivar: bool):
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = desactivar
		elif child.get_child_count() > 0:
			_desactivar_colisiones_recursivo(child, desactivar)
