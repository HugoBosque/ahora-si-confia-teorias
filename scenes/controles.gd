extends Button

@onready var lbl_controles: Label = $lbl_controles

func _ready():
	# El Label empieza oculto
	if lbl_controles:
		lbl_controles.visible = false

func _process(delta):
	if lbl_controles:
		var mouse_over = get_global_rect().has_point(get_global_mouse_position())
		lbl_controles.visible = mouse_over
