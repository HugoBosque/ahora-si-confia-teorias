extends Node

# ============================================================
# =============== VARIABLES DE HISTORIA Y FLAGS ===============
# ============================================================

var game_saved: bool = false
var tendero_des: bool = false

var dia1_hablar_cura := false
var dia2_hablar_cura := false
var dia3_hablar_cura := false
var dia4_hablar_cura := false
var dia5_hablar_cura := false
var dia6_hablar_cura := false
var dia7_hablar_cura := false

var dia1_hablar_yerik := false
var dia2_hablar_yerik := false
var dia3_hablar_yerik := false
var dia4_hablar_yerik := false
var dia5_hablar_yerik := false
var dia6_hablar_yerik := false
var dia7_hablar_yerik := false

var dia1_hablar_madre := false
var dia2_hablar_madre := false
var dia2_madre_noticia1 := false
var dia3_hablar_madre := false
var dia4_hablar_madre := false
var dia5_hablar_madre := false
var dia5_madre_sabe_marido_muerto := false
var dia6_hablar_madre := false
var dia7_hablar_madre := false

var dia1_halbar_esceptico := false
var dia2_halbar_esceptico := false
var dia3_halbar_esceptico := false
var dia4_halbar_esceptico := false
var dia5_halbar_esceptico := false
var dia6_halbar_esceptico := false
var dia7_halbar_esceptico := false

var dia1_hablar_medico := false
var dia2_hablar_medico := false
var dia3_hablar_medico := false
var dia4_hablar_medico := false
var dia5_hablar_medico := false
var dia5_alina_recomienda_reduccion_contacto := false
var dia6_hablar_medico := false
var dia7_hablar_medico := false

var dia1_hablar_viudo := false
var dia2_hablar_viudo := false
var dia3_hablar_viudo := false
var dia4_hablar_viudo := false
var dia5_hablar_viudo := false
var dia6_hablar_viudo := false
var dia7_hablar_viudo := false

var dia1_hablar_nina := false
var dia2_hablar_nina := false
var dia3_hablar_nina := false
var dia4_hablar_nina := false
var dia5_hablar_nina := false
var dia6_hablar_nina := false
var dia7_hablar_nina := false

var dia1_hablar_mikhail := false
var dia2_hablar_mikhail := false
var dia3_hablar_mikhail := false
var dia4_hablar_mikhail := false
var dia5_hablar_mikhail := false
var dia6_hablar_mikhail := false
var dia7_hablar_mikhail := false

var dia1_hablar_Viktor := false
var dia2_hablar_Viktor := false
var dia3_hablar_Viktor := false
var dia4_hablar_Viktor := false
var dia5_hablar_Viktor := false
var dia6_hablar_Viktor := false
var dia7_hablar_Viktor := false

var dia1_hablar_tendero := false
var dia2_hablar_tendero := false
var dia2_tendero_sus := false
var dia3_hablar_tendero := false
var dia3_pista_tendero_viktor := false
var dia3_tendero_contrabando := false
var dia4_hablar_tendero := false
var dia5_hablar_tendero := false
var dia6_hablar_tendero := false
var dia7_hablar_tendero := false

var yerik_miedo_afueras := false
var hablar_gato := false
var gato_hablado := false
var final_dialogo_muertos := false
var soldado_muerto_hablado := false

# ============================================================
# ================= ESTADO GENERAL ===========================
# ============================================================

var pause_menu_controller: Node = null
var is_game_paused: bool = false

var has_seen_presi_scene: bool = false
var next_spawn: Vector2 = Vector2.ZERO
var dia: int = 1

# ============================================================
# ================= READY ===================================
# ============================================================

func _ready() -> void:
	print("🌍 Global.gd cargado correctamente")

# ============================================================
# ================= RESET GAME STATE =========================
# ============================================================

func reset_game_state() -> void:
	is_game_paused = false
	print("🔄 Estado del juego reseteado")

# ============================================================
# ================= RESET TOTAL ==============================
# ============================================================

func reset_full_game() -> void:
	for prop in get_property_list():
		if prop.name == "script":
			continue

		var value = get(prop.name)

		if value is bool:
			set(prop.name, false)
		elif value is int:
			set(prop.name, 0)
		elif value is Vector2:
			set(prop.name, Vector2.ZERO)

	dia = 1
	game_saved = false
	is_game_paused = false
	final_dialogo_muertos = false

	print("🌱 Nueva partida iniciada")

# ============================================================
# ================= GUARDAR PARTIDA ==========================
# ============================================================

func save_game() -> void:
	var save_data: Dictionary = {}
	game_saved = true

	for prop in get_property_list():
		if prop.name == "script":
			continue
		save_data[prop.name] = get(prop.name)

	for prop in GameManager.get_property_list():
		if prop.name == "script":
			continue
		save_data["GM_" + prop.name] = GameManager.get(prop.name)

	var file := FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	file.store_var(save_data)
	file.close()

	print("💾 Partida guardada")

# ============================================================
# ================= CARGAR PARTIDA ===========================
# ============================================================

func load_game() -> bool:
	if not FileAccess.file_exists("user://savegame.dat"):
		print("⚠️ No hay guardado")
		return false

	var file := FileAccess.open("user://savegame.dat", FileAccess.READ)
	var save_data: Dictionary = file.get_var(true)
	file.close()

	for key in save_data.keys():
		if _property_exists(self, String(key)):
			set(String(key), save_data[key])

	for key in save_data.keys():
		if String(key).begins_with("GM_"):
			var real_key := String(key).replace("GM_", "")
			if _property_exists(GameManager, real_key):
				GameManager.set(real_key, save_data[key])

	print("✅ Partida cargada correctamente")
	return true

# ============================================================
# ================= UTILIDADES ===============================
# ============================================================

func _property_exists(obj: Object, prop_name: String) -> bool:
	for prop in obj.get_property_list():
		if prop.name == prop_name:
			return true
	return false

# ============================================================
# ================= INPUT GLOBAL =============================
# ============================================================

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		if pause_menu_controller:
			pause_menu_controller.toggle_pause_menu()
