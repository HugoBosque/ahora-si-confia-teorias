extends HSlider

func _ready():
	var bus = AudioServer.get_bus_index("Master")
	value = AudioServer.get_bus_volume_db(bus)

func _on_value_changed(value: float) -> void:
	var bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, value)
