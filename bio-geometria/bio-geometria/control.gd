extends Control


@onready var button: Button = $Botao
const SEM_SOM = preload("uid://nkhllp14tk8b")
const SOM = preload("uid://bswucvxg7mfcu")


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.icon = SOM
		print("ON")
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, false)
	else:
		button.icon = SEM_SOM
		print("OFF")
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, true)


func _on_h_slider_value_changed(value: float) -> void:
	print(value)
