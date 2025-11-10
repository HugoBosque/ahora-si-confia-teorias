extends Node

# -------------------- ESTADOS GLOBALES --------------------
var has_met_tendero = false
var is_dialogue_active = false
var has_done_dialogue1 = false
var has_done_cinematic1 = false
var has_animation_done = false

# -------------------- PROGRESO GENERAL --------------------
var dia: int = 1

# -------------------- VARIABLES DE PERSONAJES --------------------
var vida_cura: int = 100
var preocupacion_cura: int = 0
var cura_en_iglesia: bool = false  # 🔹 NUEVA VARIABLE GLOBAL DE UBICACIÓN DEL CURA

var vida_esceptico: int = 100
var preocupacion_esceptico: int = 0

var vida_madre: int = 100
var preocupacion_madre: int = 0

var vida_viktor: int = 100
var preocupacion_viktor: int = 0

var vida_viudo: int = 100
var preocupacion_viudo: int = 0

var vida_medico: int = 100
var preocupacion_medico: int = 0

var vida_nina: int = 100
var preocupacion_nina: int = 0

var vida_mikhail: int = 100
var preocupacion_mikhail: int = 0

var vida_tendero: int = 100
var preocupacion_tendero: int = 0

# -------------------- SEÑALES --------------------
signal dia_cambiado(nuevo_dia: int)

# -------------------- FUNCIONES --------------------
func cambiar_dia():
	"""
	Aumenta el día actual, emite la señal de cambio y actualiza la lógica global.
	"""
	dia += 1
	print("📆 Día cambiado a:", dia)

	actualizar_cura()
	verificar_condiciones_dia()

	emit_signal("dia_cambiado", dia)

	# 🔹 Aseguramos que la escena actual se actualice aunque no esté conectada
	var escena = get_tree().current_scene
	if escena and escena.has_method("_on_dia_cambiado"):
		escena._on_dia_cambiado(dia)

func actualizar_cura():
	"""
	Define la ubicación del cura según su nivel de preocupación.
	"""
	cura_en_iglesia = (preocupacion_cura >= 50)
	if cura_en_iglesia:
		print("⛪ El cura ahora está en la iglesia.")
	else:
		print("🏘️ El cura ahora está en el pueblo.")

func verificar_condiciones_dia():
	"""
	Verifica condiciones especiales de los días.
	Por ejemplo, si el día es 2 y la preocupación de la madre es alta,
	se registrará para que no aparezca en la escena.
	"""
	if dia == 2 and preocupacion_madre >= 80:
		print("🚫 Día 2 y preocupación_madre >= 80 → la madre no aparecerá.")
	else:
		print("✅ La madre puede aparecer normalmente.")
