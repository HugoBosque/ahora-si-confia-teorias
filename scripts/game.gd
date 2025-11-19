extends Node

@onready var cura: Area2D = $Cura/Cura
@onready var cura_2: Area2D = $Cura/Cura2
@onready var door_to_church: Area2D = $DoorToChurch
@onready var player: CharacterBody2D = $Player
@onready var medico: Area2D = $Medico/Medico
@onready var medico_2: Area2D = $Medico/Medico2
@onready var medico_3: Area2D = $Medico/Medico3
@onready var madre: Area2D = $Madre/Madre
@onready var madre_2: Area2D = $Madre/Madre2
@onready var madre_3: Area2D = $Madre/Madre3
@onready var esceptico: Area2D = $Esceptico/Esceptico
@onready var esceptico_2: Area2D = $Esceptico/Esceptico2
@onready var nina: Area2D = $Nina/nina
@onready var nina_2: Area2D = $Nina/nina2
@onready var mikhail_belov: Area2D = $"Mikhail/Mikhail Belov"
@onready var mikhail_belov_2: Area2D = $"Mikhail/Mikhail Belov2"
@onready var viktor_sokolov: Area2D = $"Viktor/Viktor Sokolov"
@onready var viktor_sokolov_2: Area2D = $"Viktor/Viktor Sokolov2"
@onready var viudo: Area2D = $Viudo/Viudo
@onready var viudo_2: Area2D = $Viudo/Viudo2
@onready var yerik_pavel: Area2D = $"Yerik/Yerik Pavel"
@onready var yerik_pavel_2: Area2D = $"Yerik/Yerik Pavel2"


func _ready():
	GameManager.connect("dia_cambiado", Callable(self, "_on_dia_cambiado"))
	_actualizar_personaje_según_preocupacion()

	if door_to_church:
		door_to_church.connect("body_entered", Callable(self, "_on_door_body_entered"))
	else:
		print("❌ ERROR: door_to_church es null. Revisa el nombre del nodo.")


func _on_dia_cambiado(nuevo_dia: int):
	print("🌅 Día cambiado en Game (pueblo):", nuevo_dia)
	_actualizar_personaje_según_preocupacion()

# -------------------- PERSONAJES --------------------
func _actualizar_personaje_según_preocupacion():
	var pme = GameManager.preocupacion_medico
	var pma = GameManager.preocupacion_madre
	var pes = GameManager.preocupacion_esceptico
	var pni = GameManager.preocupacion_nina
	var pmi = GameManager.preocupacion_mikhail
	var pvik = GameManager.preocupacion_viktor
	var pvi = GameManager.preocupacion_viudo
	var pye = GameManager.preocupacion_yerik
	var pcu = GameManager.preocupacion_cura

	print("🟢 Actualizando personajes (día: %s, preoc. madre: %s, preoc. médico: %s)" %
		[GameManager.dia, pma, pme])

	# 🔹 Limpieza previa
	desactivar_todas_madres()
	desactivar_todos_medicos()
	desactivar_todas_ninas()
	desactivar_todos_curas()
	desactivar_todos_escepticos()
	desactivar_todos_mikhail()
	desactivar_todos_viktor()
	desactivar_todos_viudos()
	desactivar_todos_yeriks()
	

	# 🔹 --- MADRE ---
	if GameManager.dia == 2 and Global.dia2_madre_noticia1:
		print("🚫 Día 2 y preocupación_madre < 80 → la madre no aparecerá.")
	elif GameManager.dia == 4:
		activar_madre(madre_2)
	else:
		if pma <= 50:
			activar_madre(madre)
		else:
			activar_madre(madre_3)

	# 🔹 --- MÉDICO ---
	if GameManager.dia == 4:
		activar_medico(medico_2)
	else:
		if pme <= 50:
			activar_medico(medico)
		else:
			activar_medico(medico_3)

	# 🔹 --- CURA ---
	if GameManager.dia == 4:
		activar_cura(cura_2)
	else:
		activar_cura(cura)

	# 🔹 --- ESCEPTICO ---
	if GameManager.dia == 4:
		activar_esceptico(esceptico_2)
	else:
		activar_esceptico(esceptico)
		
	# 🔹 --- NINA ---
	if GameManager.dia == 4:
		activar_nina(nina_2)
	else:
		activar_nina(nina)

	# 🔹 --- MIKHAIL ---
	if GameManager.dia == 4:
		activar_mikhail(mikhail_belov_2)
	else:
		activar_mikhail(mikhail_belov)

	# 🔹 --- VIKTOR ---
	if GameManager.dia == 4:
		activar_viktor(viktor_sokolov_2)
	else:
		activar_viktor(viktor_sokolov)

	# 🔹 --- VIUDO ---
	if GameManager.dia == 4:
		activar_viudo(viudo_2)
	else:
		activar_viudo(viudo)

	# 🔹 --- YERIK ---
	if GameManager.dia == 4:
		activar_yerik(yerik_pavel_2)
	else:
		activar_yerik(yerik_pavel)


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

func desactivar_todos_escepticos():
	var escepticos = [esceptico, esceptico_2]
	for e in escepticos:
		_set_personaje_activo(e, false)
		

func activar_esceptico(activo: Area2D):
	var escepticos = [esceptico, esceptico_2]
	for e in escepticos:
		if e != activo:
			_set_personaje_activo(e, false)
	_set_personaje_activo(activo, true)

func desactivar_todas_ninas():
	var ninas = [nina, nina_2]
	for n in ninas:
		_set_personaje_activo(n, false)

func activar_nina(activo: Area2D):
	var ninas = [nina, nina_2]
	for n in ninas:
		if n != activo:
			_set_personaje_activo(n, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_mikhail():
	var mikhails = [mikhail_belov, mikhail_belov_2]
	for m in mikhails:
		_set_personaje_activo(m, false)

func activar_mikhail(activo: Area2D):
	var mikhails = [mikhail_belov, mikhail_belov_2]
	for m in mikhails:
		if m != activo:
			_set_personaje_activo(m, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_viktor():
	var viktors = [viktor_sokolov, viktor_sokolov_2]
	for v in viktors:
		_set_personaje_activo(v, false)

func activar_viktor(activo: Area2D):
	var viktors = [viktor_sokolov, viktor_sokolov_2]
	for v in viktors:
		if v != activo:
			_set_personaje_activo(v, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_viudos():
	var viudos = [viudo, viudo_2]
	for v in viudos:
		_set_personaje_activo(v, false)

func activar_viudo(activo: Area2D):
	var viudos = [viudo, viudo_2]
	for v in viudos:
		if v != activo:
			_set_personaje_activo(v, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_yeriks():
	var yeriks = [yerik_pavel, yerik_pavel_2]
	for y in yeriks:
		_set_personaje_activo(y, false)

func activar_yerik(activo: Area2D):
	var yeriks = [yerik_pavel, yerik_pavel_2]
	for y in yeriks:
		if y != activo:
			_set_personaje_activo(y, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_curas():
	var curas = [cura, cura_2]
	for c in curas:
		_set_personaje_activo(c, false)

func activar_cura(activo: Area2D):
	var curas = [cura, cura_2]
	for c in curas:
		if c != activo:
			_set_personaje_activo(c, false)
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



# -------------------- PUERTA --------------------
func _on_door_body_entered(body: Node):
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/Iglesia.tscn")


func _on_door_to_cave_body_entered(body: Node2D) -> void:
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/cueva.tscn")
