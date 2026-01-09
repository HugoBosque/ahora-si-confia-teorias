extends Node

# ============================================================
# =============== VARIABLES DE HISTORIA Y FLAGS ===============
# ============================================================
var game_saved = false
var tendero_des = false
var dia1_hablar_cura = false
var dia2_hablar_cura = false
var dia3_hablar_cura = false
var dia4_hablar_cura = false
var dia5_hablar_cura = false
var dia6_hablar_cura = false
var dia7_hablar_cura = false

var dia1_hablar_yerik = false
var dia2_hablar_yerik = false
var dia3_hablar_yerik = false
var dia4_hablar_yerik = false
var dia5_hablar_yerik = false
var dia6_hablar_yerik = false
var dia7_hablar_yerik = false

var dia1_hablar_madre = false
var dia2_hablar_madre = false
var dia2_madre_noticia1 = false
var dia3_hablar_madre = false
var dia4_hablar_madre = false
var dia5_hablar_madre = false
var dia5_madre_sabe_marido_muerto = false
var dia6_hablar_madre = false
var dia7_hablar_madre = false

var dia1_halbar_esceptico = false
var dia2_halbar_esceptico = false
var dia3_halbar_esceptico = false
var dia4_halbar_esceptico = false
var dia5_halbar_esceptico = false
var dia6_halbar_esceptico = false
var dia7_halbar_esceptico = false

var dia1_hablar_medico = false
var dia2_hablar_medico = false
var dia3_hablar_medico = false
var dia4_hablar_medico = false
var dia5_hablar_medico = false
var dia5_alina_recomienda_reduccion_contacto = false
var dia6_hablar_medico = false
var dia7_hablar_medico = false

var dia1_hablar_viudo = false
var dia2_hablar_viudo = false
var dia3_hablar_viudo = false
var dia4_hablar_viudo = false
var dia5_hablar_viudo = false
var dia6_hablar_viudo = false
var dia7_hablar_viudo = false

var dia1_hablar_nina = false
var dia2_hablar_nina = false
var dia3_hablar_nina = false
var dia4_hablar_nina = false
var dia5_hablar_nina = false
var dia6_hablar_nina = false
var dia7_hablar_nina = false

var dia1_hablar_mikhail = false
var dia2_hablar_mikhail = false
var dia3_hablar_mikhail = false
var dia4_hablar_mikhail = false
var dia5_hablar_mikhail = false
var dia6_hablar_mikhail = false
var dia7_hablar_mikhail = false

var dia1_hablar_Viktor = false
var dia2_hablar_Viktor = false
var dia3_hablar_Viktor = false
var dia4_hablar_Viktor = false
var dia5_hablar_Viktor = false
var dia6_hablar_Viktor = false
var dia7_hablar_Viktor = false

var dia1_hablar_tendero = false
var dia2_hablar_tendero = false
var dia2_tendero_sus = false
var dia3_hablar_tendero = false
var dia3_pista_tendero_viktor = false
var dia3_tendero_contrabando = false
var dia4_hablar_tendero = false
var dia5_hablar_tendero = false
var dia6_hablar_tendero = false
var dia7_hablar_tendero = false

var hablar_gato = false

var final_dialogo_muertos = false

# Nodo de menú de pausa registrado por la escena actual
var pause_menu_controller: Node = null
var is_game_paused: bool = false

var has_seen_presi_scene: bool = false
var next_spawn: Vector2 = Vector2.ZERO
var dia: int = 1  # día actual

func _ready():
	print("🌍 Global cargado — preparado para guardar y cargar partidas.")

# ============================================================
# ================= FUNCIÓN NUEVA: RESET GAME STATE ==========
# ============================================================

func reset_game_state():
	is_game_paused = false
	print("🔄 Estado del juego reseteado - is_game_paused = false")

# ============================================================
# ================= SISTEMA DE GUARDADO ======================
# ============================================================

func save_game():
	var save_data = {}
	game_saved = true
	# Guardar todas las propiedades del Global
	for prop in get_property_list():
		if prop.name in ["script"]:
			continue
		save_data[prop.name] = get(prop.name)

	# Guardar propiedades del GlobalManager
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		for prop in gm.get_property_list():
			if prop.name in ["script"]:
				continue
			save_data["GM_" + prop.name] = gm.get(prop.name)

	var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	file.store_var(save_data)
	file.close()
	print("💾 Partida guardada correctamente:", save_data)

# ============================================================
# ================= SISTEMA DE CARGA ========================
# ============================================================

func load_game() -> bool:
	if not FileAccess.file_exists("user://savegame.dat"):
		print("⚠️ No hay archivo de guardado todavía.")
		return false

	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	var save_data = file.get_var()
	file.close()

	# Restaurar datos del Global
	for key in save_data.keys():
		if _property_exists(self, key):
			set(key, save_data[key])

	# Restaurar datos del GlobalManager
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		for key in save_data.keys():
			if key.begins_with("GM_"):
				var real_key = key.replace("GM_", "")
				if _property_exists(gm, real_key):
					gm.set(real_key, save_data[key])

	print("✅ Partida cargada correctamente:", save_data)
	return true

# ============================================================
# ================= FUNCIONES AUXILIARES ====================
# ============================================================

func _property_exists(obj: Object, prop_name: String) -> bool:
	for prop in obj.get_property_list():
		if prop.name == prop_name:
			return true
	return false

# ============================================================
# ================= INPUT GLOBAL (ESC) ======================
# ============================================================

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):  # "cancel" = Esc
		if pause_menu_controller:
			pause_menu_controller.toggle_pause_menu()
