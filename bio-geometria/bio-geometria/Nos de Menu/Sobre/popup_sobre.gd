
extends Control

@onready var panel_fundo: Panel = $Panel


const POPUP_WIDTH = 800
const POPUP_HEIGHT = 500

func _ready():
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var viewport_size = get_viewport_rect().size
	panel_fundo.size = Vector2(POPUP_WIDTH, POPUP_HEIGHT)
	panel_fundo.position = (viewport_size / 2) - (panel_fundo.size / 2)
	$Panel/MarginContainer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
func _on_fechar_pressed() -> void:
	queue_free()
