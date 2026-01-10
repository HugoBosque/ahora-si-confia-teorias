extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@export var display_time: float = 0.3
@export var grow_time: float = 0.3

var escala_final: Vector2

func _ready():
	if sprite_2d:
		# Guardamos la escala puesta manualmente en el editor
		escala_final = sprite_2d.scale

		sprite_2d.visible = false
		sprite_2d.scale = Vector2.ZERO  # Empieza en 0

	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and sprite_2d:
		sprite_2d.visible = true
		sprite_2d.scale = Vector2.ZERO  # Reinicia a 0

		# Sonido jumpscare
		if audio_stream_player:
			audio_stream_player.play()

		# Tween: 0 → escala del editor
		var tween = create_tween()
		tween.tween_property(
			sprite_2d,
			"scale",
			escala_final,
			grow_time
		).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

		await tween.finished
		await get_tree().create_timer(display_time - grow_time).timeout

		if audio_stream_player:
			audio_stream_player.stop()

		sprite_2d.visible = false
		queue_free()


func _on_body_exited(body: Node2D) -> void:
	pass
