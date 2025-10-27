extends Node

var has_met_tendero = false
var is_dialogue_active = false
var has_done_dialogue1 = false

var dia: int = 1
var vida_cura: int = 100
var satisfacion_cura: int = 0
var preocupacion_cura: int = 0

var vida_esceptico: int = 100
var satisfacion_esceptico: int = 0
var preocupacion_esceptico: int = 0

signal dia_cambiado(nuevo_dia: int)

func cambiar_dia():
	dia += 1
	emit_signal("dia_cambiado", dia)
	actualizar_cura()

func actualizar_cura():
	# Aquí decides dónde está el cura según su preocupación
	if preocupacion_cura >= 50:
		print("→ El cura está en la iglesia.")
	else:
		print("→ El cura está en el pueblo.")
