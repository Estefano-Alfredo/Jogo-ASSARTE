extends Button

signal resposta_selecionada(resposta: String)
@export var forma: String

func _on_gui_input(event: InputEvent) -> void:
	#print(event)
	if event is InputEventMouseButton and event.button_index == 1 and not event.is_pressed():
				#if event.pressed == false:
		print("Resposta escolhida")
		resposta_selecionada.emit(forma, $".")
