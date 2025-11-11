extends Control

signal continuar_pressionado 
signal sair_pressionado 

func _ready():
	# Isso garante que o jogo PAUSE assim que o popup for carregado
	get_tree().paused = true

func _on_continuar_pressed() -> void:
	get_tree().paused = false 
	queue_free() 


func _on_sair_para_o_menu_pressed() -> void:
	get_tree().paused = false 
	# Emitir um sinal para que o script do nivel faça a transição
	emit_signal("sair_pressionado")
	queue_free()
