extends Node

@export var x := false
@export var forma := ""

var offset

signal forma_escolhida(formato: String)
signal forma_desescolhida(node)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed == true:
				forma_escolhida.emit(forma)
				x = true
				offset = $".".get_local_mouse_position()
			else:
				forma_desescolhida.emit($".")
				x = false

func _process(_delta: float) -> void:
	if x:
		$".".position = get_viewport().get_mouse_position() - offset
