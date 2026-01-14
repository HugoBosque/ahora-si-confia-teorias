extends Node2D

@onready var confirmar_dormir: ConfirmationDialog = $ConfirmarDormir

func _ready():
	confirmar_dormir.confirmed.connect(_on_confirmar_si)
	confirmar_dormir.canceled.connect(_on_confirmar_no)

func mostrar_confirmacion_dormir():
	confirmar_dormir.popup_centered()

func _on_confirmar_si():
	GameManager.comprobar_vidas()
	get_tree().change_scene_to_file(
		"res://scenes/cinemarografia/video_stream_player.tscn"
	)

func _on_confirmar_no():
	# No hace nada, simplemente se cierra
	GameManager.is_dialogue_active = false
	pass
