extends Area2D

@onready var exclamacion: Sprite2D = $Exclamacion

func _ready():
	exclamacion.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	exclamacion.visible = true


func _on_body_exited(body: Node2D) -> void:
	exclamacion.visible = false
