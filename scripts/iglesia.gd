extends Node

@onready var cura: Area2D = $Cura
@onready var madre: Area2D = $Madre

func _ready():
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_cura()
	_actualizar_madre()

func _on_dia_cambiado(nuevo_dia: int):
	_actualizar_cura()
	_actualizar_madre()

# -------------------- CURA --------------------
func _actualizar_cura():
	if GameManager.vida_cura > 0 and GameManager.preocupacion_cura >= 75:
		var debe_aparecer = true
		_set_personaje_activo(cura, debe_aparecer)
	else:
		_set_personaje_activo(cura, false)

# -------------------- MADRE --------------------
func _actualizar_madre():
	var dia = GameManager.dia
	var preoc = GameManager.preocupacion_madre

	# Regla general:
	# 🔹 La madre NO aparece ningún día
	# 🔹 EXCEPTO en día 2 si la preocupación < 80

	var debe_aparecer = false

	if dia == 2 and Global.dia2_madre_noticia1 and GameManager.vida_madre > 0:
		debe_aparecer = true

	_set_personaje_activo(madre, debe_aparecer)

	# Si aparece, reproducir animación idle_up
	if debe_aparecer:
		var anim = madre.get_node_or_null("AnimatedSprite2D")
		if anim and anim.sprite_frames.has_animation("idle_up"):
			anim.play("idle_up")

# -------------------- ACTIVADOR GENERICO --------------------
func _set_personaje_activo(personaje: Node, activo: bool):
	if personaje == null:
		return

	personaje.visible = activo

	# Desactivar/activar áreas y colisiones dentro del personaje
	for node in personaje.get_children():
		if node is Area2D:
			node.set_deferred("monitoring", activo)
			node.set_deferred("monitorable", activo)

		if node is CollisionShape2D:
			node.disabled = not activo

		for sub in node.get_children():
			if sub is CollisionShape2D:
				sub.disabled = not activo
