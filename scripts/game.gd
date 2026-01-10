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
@onready var esceptico_3: Area2D = $Esceptico/Esceptico3
@onready var nina: Area2D = $Nina/nina
@onready var nina_2: Area2D = $Nina/nina2
@onready var nina_3: Area2D = $Nina/nina3
@onready var mikhail_belov: Area2D = $"Mikhail/Mikhail Belov"
@onready var mikhail_belov_2: Area2D = $"Mikhail/Mikhail Belov2"
@onready var mikhail_belov_3: Area2D = $"Mikhail/Mikhail Belov3"
@onready var viktor_sokolov: Area2D = $"Viktor/Viktor Sokolov"
@onready var viktor_sokolov_2: Area2D = $"Viktor/Viktor Sokolov2"
@onready var viktor_sokolov_3: Area2D = $"Viktor/Viktor Sokolov3"
@onready var viudo: Area2D = $Viudo/Viudo
@onready var viudo_2: Area2D = $Viudo/Viudo2
@onready var viudo_3: Area2D = $Viudo/Viudo3
@onready var yerik_pavel: Area2D = $"Yerik/Yerik Pavel"
@onready var yerik_pavel_2: Area2D = $"Yerik/Yerik Pavel2"
@onready var yerik_pavel_3: Area2D = $"Yerik/Yerik Pavel3"
@onready var dia_4_talk: Area2D = $"dia 4 talk"
@onready var tendero: Area2D = $tendero/tendero
@onready var tendero_2: Area2D = $tendero/tendero2
@onready var tendero_3: Area2D = $tendero/tendero3



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
	var pte = GameManager.preocupacion_tendero

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
	desactivar_todos_tenderos()


	
	if GameManager.dia == 4:
		dia_4_talk.monitoring = true
	else:
		dia_4_talk.monitoring = false
		
	# 🔹 --- MADRE ---
	if GameManager.vida_madre <= 0:
		print("madre muerta")
	elif GameManager.dia == 2 and Global.dia2_madre_noticia1:
		print("🚫 Día 2 y preocupación_madre < 80 → la madre no aparecerá.")
	elif GameManager.dia == 4:
		activar_madre(madre_2)
	else:
		if Global.dia5_madre_sabe_marido_muerto == true:
			activar_madre(madre_3)
		elif pma < 75:
			activar_madre(madre)
		else:
			activar_madre(madre_3)

	# 🔹 --- MÉDICO ---
	if GameManager.vida_medico <= 0:
		print("medico muerta")
	elif GameManager.dia == 4:
		activar_medico(medico_2)
	else:
		if pme < 75:
			activar_medico(medico)
		else:
			activar_medico(medico_3)

	# 🔹 --- CURA ---
	if GameManager.vida_cura <= 0:
		print("cura muerto")
	elif GameManager.dia == 4:
		activar_cura(cura_2)
	else:
		if pcu < 75:
			activar_cura(cura)
		else:
			desactivar_todos_curas()

	# 🔹 --- ESCEPTICO ---
	if GameManager.vida_esceptico <= 0:
		print("esceptico muerto")
	elif GameManager.dia == 4:
		activar_esceptico(esceptico_2)
	else:
		if pes < 75:
			activar_esceptico(esceptico)
		else:
			activar_esceptico(esceptico_3)
			
	# 🔹 --- NINA ---
	if GameManager.vida_nina <= 0:
		print("nina muerta")
	elif GameManager.dia == 4:
		activar_nina(nina_2)
	else:
		if pni < 75:
			activar_nina(nina)
		else:
			activar_nina(nina_3)
			
	# 🔹 --- MIKHAIL ---
	if GameManager.vida_mikhail <= 0:
		print("mikhail muerto")
	elif GameManager.dia == 4:
		activar_mikhail(mikhail_belov_2)
	else:
		if pmi < 75:
			activar_mikhail(mikhail_belov)
		else:
			activar_mikhail(mikhail_belov_3)
			
	# 🔹 --- VIKTOR ---
	if GameManager.vida_viktor <= 0:
		print("viktor muerto")
	elif GameManager.dia == 4:
		activar_viktor(viktor_sokolov_2)
	else:
		if pvik < 75:
			activar_viktor(viktor_sokolov)
		else:
			activar_viktor(viktor_sokolov_3)

	# 🔹 --- VIUDO ---
	if GameManager.vida_viudo <= 0:
		print("viudo muerto")
	elif GameManager.dia == 4:
		activar_viudo(viudo_2)
	else:
		if pvi < 75:
			activar_viudo(viudo)
		else:
			activar_viudo(viudo_3)

	# 🔹 --- YERIK ---
	if GameManager.vida_yerik <= 0:
		print("yerik muerto")
	elif GameManager.dia == 4:
		activar_yerik(yerik_pavel_2)
	else:
		if pye < 75:
			activar_yerik(yerik_pavel)
		else:
			activar_yerik(yerik_pavel_3)

	# 🔹 --- TENDERO ---
	if GameManager.vida_tendero <= 0:
		print("tendero muerto")
	elif Global.dia3_pista_tendero_viktor and GameManager.dia == 6 or Global.dia3_pista_tendero_viktor and GameManager.dia == 7:
		Global.tendero_des = true
	elif GameManager.dia == 4:
		activar_tenderos(tendero_2)
	else:
		if pte < 75:
			activar_tenderos(tendero)
		else:
			activar_tenderos(tendero_3)


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
	var escepticos = [esceptico, esceptico_2, esceptico_3]
	for e in escepticos:
		_set_personaje_activo(e, false)
		 

func activar_esceptico(activo: Area2D):
	var escepticos = [esceptico, esceptico_2, esceptico_3]
	for e in escepticos:
		if e != activo:
			_set_personaje_activo(e, false)
	_set_personaje_activo(activo, true)

func desactivar_todas_ninas():
	var ninas = [nina, nina_2, nina_3]
	for n in ninas:
		_set_personaje_activo(n, false)

func activar_nina(activo: Area2D):
	var ninas = [nina, nina_2, nina_3]
	for n in ninas:
		if n != activo:
			_set_personaje_activo(n, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_mikhail():
	var mikhails = [mikhail_belov, mikhail_belov_2, mikhail_belov_3]
	for m in mikhails:
		_set_personaje_activo(m, false)

func activar_mikhail(activo: Area2D):
	var mikhails = [mikhail_belov, mikhail_belov_2, mikhail_belov_3]
	for m in mikhails:
		if m != activo:
			_set_personaje_activo(m, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_viktor():
	var viktors = [viktor_sokolov, viktor_sokolov_2, viktor_sokolov_3]
	for v in viktors:
		_set_personaje_activo(v, false)

func activar_viktor(activo: Area2D):
	var viktors = [viktor_sokolov, viktor_sokolov_2, viktor_sokolov_3]
	for v in viktors:
		if v != activo:
			_set_personaje_activo(v, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_viudos():
	var viudos = [viudo, viudo_2, viudo_3]
	for v in viudos:
		_set_personaje_activo(v, false)

func activar_viudo(activo: Area2D):
	var viudos = [viudo, viudo_2, viudo_3]
	for v in viudos:
		if v != activo:
			_set_personaje_activo(v, false)
	_set_personaje_activo(activo, true)

func desactivar_todos_yeriks():
	var yeriks = [yerik_pavel, yerik_pavel_2, yerik_pavel_3]
	for y in yeriks:
		_set_personaje_activo(y, false)

func activar_yerik(activo: Area2D):
	var yeriks = [yerik_pavel, yerik_pavel_2, yerik_pavel_3]
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
	
func desactivar_todos_tenderos():
	var tenderos = [tendero, tendero_2, tendero_3]
	for t in tenderos:
		_set_personaje_activo(t, false)

func activar_tenderos(activo: Area2D):
	var tenderos = [tendero, tendero_2, tendero_3]
	for t in tenderos:
		if t != activo:
			_set_personaje_activo(t, false)
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


func _on_door_to_cave_body_entered(body: Node2D) -> void:
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/cueva.tscn")


func _on_door_to_church_body_entered(body: Node2D) -> void:
	if body == player:
		GameManager.is_dialogue_active = true
		get_tree().change_scene_to_file("res://scenes/iglesia.tscn")
