extends Control

signal popup_fechado

var info_text: String = ""

var info_audio: AudioStream = null 

@onready var rich_text_label: RichTextLabel = $Panel/MarginContainer/VBoxContainer/RichTextLabel

@onready var audio_narracao: AudioStreamPlayer = $AudioNarracao 

func _ready():
	rich_text_label.bbcode_enabled = true
	
	if info_text != "":
		rich_text_label.text = info_text
	
	if info_audio != null:
		audio_narracao.stream = info_audio
		audio_narracao.play()

func _on_continuar_pressed() -> void:
	if audio_narracao.playing:
		audio_narracao.stop()
	emit_signal("popup_fechado")
	queue_free()
