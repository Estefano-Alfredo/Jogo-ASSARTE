extends Control
signal popup_fechado


@onready var rich_text_label: RichTextLabel = $Panel/MarginContainer/VBoxContainer/RichTextLabel

func set_text(texto_para_mostrar: String):
	rich_text_label.bbcode_enabled = true
	rich_text_label.text = texto_para_mostrar
	
func _on_continuar_pressed() -> void:
	emit_signal("popup_fechado")
	queue_free()
