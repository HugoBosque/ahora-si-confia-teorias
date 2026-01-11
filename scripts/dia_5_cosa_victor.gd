extends Area2D



var player_in_area = false

func _ready():
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(area) -> void:
	if area.name == "Player":
		player_in_area = true


func _on_body_exited(area) -> void:
	if area.name == "Player":
		player_in_area = false


func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("accept"):
		print("vicniga")
