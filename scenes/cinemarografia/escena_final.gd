extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var disparo: AudioStreamPlayer = $Disparo

# Diálogo
const FINALPRESI = preload("uid://dyhlvnqxsxsm")

# Escenas finales
const FINAL1 = preload("res://scenes/dias/Final_Mueres.tscn")
const FINAL2 = preload("res://scenes/dias/Final_Vives.tscn") # ← cambia la ruta si hace falta

var dialogo_iniciado = false
var pantalla_negra: ColorRect
var fade_tiempo = 3


func _ready() -> void:
	sprite_2d.visible = false

	# Crear pantalla negra con shader
	pantalla_negra = ColorRect.new()
	pantalla_negra.color = Color.WHITE
	pantalla_negra.size = get_viewport_rect().size
	pantalla_negra.visible = true
	pantalla_negra.z_index = 1000
	add_child(pantalla_negra)

	var shader_code = """
	shader_type canvas_item;
	uniform float alpha : hint_range(0.0, 1.0) = 1.0;
	void fragment() {
		COLOR = vec4(0.0, 0.0, 0.0, alpha);
	}
	"""
	var shader = Shader.new()
	shader.code = shader_code
	var material = ShaderMaterial.new()
	material.shader = shader
	pantalla_negra.material = material
	pantalla_negra.material.set("shader_param/alpha", 1.0)

	# Fade de entrada
	call_deferred("_fade_in_scene")

	# Señales del DialogueManager
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	# Iniciar diálogo
	call_deferred("_iniciar_dialogo")


func _fade_in_scene() -> void:
	await fade_from_black(fade_tiempo)


func fade_from_black(duration: float) -> void:
	var t := 0.0
	while t < duration:
		t += get_process_delta_time()
		var alpha = clamp(1.0 - (t / duration), 0, 1)
		pantalla_negra.material.set("shader_param/alpha", alpha)
		await get_tree().process_frame


func _iniciar_dialogo():
	if not dialogo_iniciado:
		DialogueManager.show_dialogue_balloon(FINALPRESI, "start")
		dialogo_iniciado = true


func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true


func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false

	# Fade a negro
	await fade_to_black(fade_tiempo)

	# 🔫 Solo suena el disparo si NO es el final alternativo
	if not Global.final_dialogo_muertos:
		if disparo:
			disparo.play()

	# ⏱️ Espera igual siempre
	await get_tree().create_timer(3).timeout

	# 🎬 Cambio de escena según el final
	if Global.final_dialogo_muertos:
		get_tree().change_scene_to_packed(FINAL2)
	else:
		get_tree().change_scene_to_packed(FINAL1)


func fade_to_black(duration: float) -> void:
	var t := 0.0
	while t < duration:
		t += get_process_delta_time()
		var alpha = clamp(t / duration, 0, 1)
		pantalla_negra.material.set("shader_param/alpha", alpha)
		await get_tree().process_frame
