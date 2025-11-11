extends Button

@export var resposta : int # Cria variavel para resposta
signal resposta_selecionada # Cria um sinal para emisão de resposta


func _on_pressed() -> void:
	Global.selecionado_1 = resposta
	emit_signal("resposta_selecionada")
