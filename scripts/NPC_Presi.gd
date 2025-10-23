extends Area2D


const MY_DIALOGUE = preload("uid://dqx4dn8r3g2br")

var is_player_close = false
var is_dialogue_done = false

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _process(delta: float) -> void:
	if is_player_close and not GameManager.is_dialogue_active and not is_dialogue_done:
		DialogueManager.show_dialogue_balloon(MY_DIALOGUE, "start")
		
		# por si queremos que diga algo mas despues de que le diga el primer dialogo.
#	elif is_player_close and not GameManager.is_dialogue_active and Input.is_action_just_pressed("ui_accept"):
#		DialogueManager.show_dialogue_balloon(MY_DIALOGUE, "start")

func _on_area_entered(area):
	
	is_player_close = true

func _on_area_exited(area: Area2D) -> void:
	
	is_player_close = false
	
func _on_dialogue_started(dialogue):
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false
	is_dialogue_done = true
