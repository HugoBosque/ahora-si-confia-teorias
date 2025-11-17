extends Node

@onready var cura: Area2D = $Cura
@onready var door_to_church: Area2D = $DoorToChurch
@onready var player: CharacterBody2D = $Player
@onready var medico_3: Area2D = $Medico3
@onready var medico_2: Area2D = $Medico2
@onready var medico: Area2D = $Medico
@onready var madre_2: Area2D = $Madre2
@onready var madre_3: Area2D = $Madre3
@onready var madre: Area2D = $Madre

func _ready():
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_presencia_cura()
	_actualizar_personaje_según_preocupacion()

	if door_to_church:
		door_to_church.connect("body_entered", Callable(self, "_on_door_body_entered"))
	else:
		print("❌ ERROR: door_to_church es null. Revisa el nombre del nodo.")


func _on_dia_cambiado(nuevo_dia: int):
	print("🌅 Día cambiado en Game (pueblo):", nuevo_dia)
	_actualizar_presencia_cura()
	_actualizar_personaje_según_preocupacion()

# -------------------- PERSONAJES --------------------
func _actualizar_personaje_según_preocupacion():
	var pme = GameManager.preocupacion_medico
	var pma = GameManager.preocupacion_madre

	print("🟢 Actualizando personajes (día: %s, preoc. madre: %s, preoc. médico: %s)" %
		[GameManager.dia, pma, pme])

	# 🔹 Limpieza previa
	desactivar_todas_madres()
	desactivar_todos_medicos()

	# 🔹 --- MADRE ---
	if GameManager.dia == 2 and Global.dia2_madre_noticia1:
		print("🚫 Día 2 y preocupación_madre < 80 → la madre no aparecerá.")
	else:
		if pma <= 33:
			activar_madre(madre)
		elif pma <= 66:
			activar_madre(madre_2)
		else:
			activar_madre(madre_3)

	# 🔹 --- MÉDICO ---
	if pme <= 33:
		activar_medico(medico)
	elif pme <= 66:
		activar_medico(medico_2)
	else:
		activar_medico(medico_3)

# -------------------- FUNCIONES DE ACTIVACIÓN --------------------
func desactivar_todas_madres():
	var madres = [madre, madre_2, madre_3]
	for m in madres:
		_set_personaje_activo(m, false)

func activar_madre(activo: Area2D):
	var madres = [madre, madre_2, madre_3]
	for m in madres:
		if m != activo:
			_set_personaje_activo(m, false)
	_set_personaje_activo(activo, true)

	# Cambiar animación a idle_down si existe
	var anim = activo.get_node_or_null("AnimatedSprite2D")
	if anim and anim.sprite_frames.has_animation("idle_down"):
		anim.play("idle_down")

func desactivar_todos_medicos():
	var medicos = [medico, medico_2, medico_3]
	for m in medicos:
		_set_personaje_activo(m, false)

func activar_medico(activo: Area2D):
	var medicos = [medico, medico_2, medico_3]
	for m in medicos:
		if m != activo:
			_set_personaje_activo(m, false)
	_set_personaje_activo(activo, true)

# 🔹 Función genérica para activar o desactivar un personaje (madre o médico)
func _set_personaje_activo(personaje: Area2D, activo: bool):
	if personaje == null:
		return

	personaje.visible = activo
	personaje.set_deferred("monitoring", activo)
	personaje.set_deferred("monitorable", activo)

	# Desactivar todas las CollisionShape2D, incluso dentro del CharacterBody2D
	for child in personaje.get_children():
		if child is CollisionShape2D:
			child.disabled = not activo
		elif child is CharacterBody2D:
			for grandchild in child.get_children():
				if grandchild is CollisionShape2D:
					grandchild.disabled = not activo

# -------------------- CURA --------------------
func _actualizar_presencia_cura():
	# 🔹 Ahora el cura está en el pueblo si NO está en la iglesia globalmente
	if GameManager.preocupacion_cura <= 50:
		_set_personaje_activo(cura, true)

# -------------------- PUERTA --------------------
func _on_door_body_entered(body: Node):
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/Iglesia.tscn")


func _on_door_to_cave_body_entered(body: Node2D) -> void:
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/cueva.tscn")
