extends Node

@onready var cura: Area2D = $Cura
@onready var madre: Area2D = $Madre

func _ready():
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_presencia_cura()
	_actualizar_presencia_madre()

func _on_dia_cambiado(nuevo_dia: int):
	_actualizar_presencia_cura()
	_actualizar_presencia_madre()

# -------------------- CURA --------------------
func _actualizar_presencia_cura():
	var activo = GameManager.preocupacion_cura >= 50
	cura.visible = activo
	cura.set_deferred("monitoring", activo)
	cura.set_deferred("monitorable", activo)
	_desactivar_colisiones_recursivo(cura, not activo)

# -------------------- MADRE --------------------
func _actualizar_presencia_madre():
	var aparece = (GameManager.dia == 2 and GameManager.preocupacion_madre < 80)
	madre.visible = aparece
	madre.set_deferred("monitoring", aparece)
	madre.set_deferred("monitorable", aparece)
	_desactivar_colisiones_recursivo(madre, not aparece)

	if aparece:
		var madre_anim = madre.get_node_or_null("AnimatedSprite2D")
		if madre_anim and madre_anim.sprite_frames.has_animation("idle_up"):
			madre_anim.play("idle_up")
		else:
			push_warning("⚠ No se encontró 'AnimatedSprite2D' o la animación 'idle_up' dentro de Madre")

# -------------------- COLISIONES --------------------
func _desactivar_colisiones_recursivo(node: Node, desactivar: bool):
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = desactivar
		elif child.get_child_count() > 0:
			_desactivar_colisiones_recursivo(child, desactivar)
