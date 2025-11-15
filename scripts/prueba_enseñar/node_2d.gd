extends Node2D

#@onready var tendero: Area2D = $tendero
#@onready var tendero_2: Area2D = $tendero2
#@onready var tendero_3: Area2D = $tendero3

#func _ready():
#	_actualizar_personaje_según_preocupacion()

#func _actualizar_personaje_según_preocupacion():
#	var p = GameManager.preocupacion_cura

	# Decide qué tendero debe aparecer según la preocupación
#	if p <= 33:
#		activar_personaje(tendero)
#	elif p <= 66:
#		activar_personaje(tendero_2)
#	else:
#		activar_personaje(tendero_3)

#func activar_personaje(activo: Area2D):
#	var tenderos = [tendero, tendero_2, tendero_3]
#	
#	for t in tenderos:
#		if t != activo:
#		if t != activo:
#			t.queue_free()  # Elimina los tenderos que no van a usarse

	# Asegúrate de que el tendero activo esté visible y listo para interactuar
#	activo.visible = true
#	activo.set_deferred("monitoring", true)  # Habilita la detección de colisiones
