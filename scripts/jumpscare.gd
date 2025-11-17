extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var display_time: float = 0.3   # Duración total que aparece
@export var grow_time: float = 0.3      # Tiempo que tarda en crecer

func _ready():
	if sprite_2d:
		sprite_2d.visible = false
		sprite_2d.scale = Vector2(0.1, 0.1)  # Empieza diminuta
	# Conectar señales si no lo hiciste en el editor
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and sprite_2d:
		sprite_2d.visible = true
		sprite_2d.scale = Vector2(0.1, 0.1)  # Reinicia escala

		# Reproducir sonido jumpscare
		if audio_stream_player:
			audio_stream_player.play()

		# Crear Tween para hacer crecer el sprite
		var tween = create_tween()
		tween.tween_property(sprite_2d, "scale", Vector2(1, 1), grow_time).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

		# Esperar que termine el crecimiento
		await tween.finished
		# Esperar el tiempo restante
		await get_tree().create_timer(display_time - grow_time).timeout

		# Detener el sonido y limpiar
		if audio_stream_player:
			audio_stream_player.stop()
		sprite_2d.visible = false
		queue_free()  # Borra el Area2D y todos sus hijos


func _on_body_exited(body: Node2D) -> void:
	pass  # No necesitamos hacer nada aquí
