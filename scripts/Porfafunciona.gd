extends Node2D

func _ready():
	# Conecta la señal desde tu Area2D
	$TuArea2D.dialogue_finished.connect(_on_dialogue_finished)

func _on_dialogue_finished():
	$AnimationPlayer.play("acto1")
