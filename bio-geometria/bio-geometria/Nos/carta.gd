extends Button

@export var valor_da_carta : int
var amostra := false
var correto := false
signal teste

#func _process(delta: float) -> void:
	#text = str(valor_da_carta)
	#pass

func _on_pressed() -> void:
	
	if amostra == false:
		if Global.selecionado_2 == 0:
			amostra = true
			text = str(valor_da_carta)
			if Global.selecionado_1 == 0:
				Global.selecionado_1 = valor_da_carta
			else:
				Global.selecionado_2 = valor_da_carta
				emit_signal("teste")

func esconder_carta():
	amostra = false
	text = ""
