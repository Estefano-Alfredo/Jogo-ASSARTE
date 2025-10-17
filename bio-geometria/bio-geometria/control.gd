extends Control

const SEM_SOM = preload("uid://nkhllp14tk8b")
const SOM = preload("uid://bswucvxg7mfcu")

@onready var button: Button = $Botao
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var slider: HSlider = $HSlider

func _ready() -> void:
	slider.value = Global.volume

func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.icon = SOM
		slider.value = Global.volume_temp
	else:
		button.icon = SEM_SOM
		Global.volume_temp = Global.volume
		slider.value = 0


func _on_h_slider_value_changed(value: float) -> void:
	var sfx_index = AudioServer.get_bus_index("Master")
	Global.volume = value
	if value > 0:
		audio_player.play()
		Global.volume_temp = value
		button.button_pressed = true
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(Global.volume))


func _on_button_pressed() -> void:
	audio_player.play()
