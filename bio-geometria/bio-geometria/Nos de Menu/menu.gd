extends Control

const POPUP_NOME_SCENE = preload("res://Nos de Menu/popup_nome.tscn")

func _on_button_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	# Cria a instância da cena Popup
	var popup_nome = POPUP_NOME_SCENE.instantiate()
	# Conecta o sinal e vai para iniciar_jogo
	popup_nome.nome_confirmado.connect(_iniciar_jogo)
	add_child(popup_nome)
	popup_nome.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

func _on_configurar_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/configuracao.tscn")

func _on_relatorio_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/tela_relatorio.tscn")

#chamada somente quando o popup emite o sinal
func _iniciar_jogo(nome_recebido: String) -> void:
	print("Nome confirmado: " + nome_recebido + ". Iniciando Fase 1...")
	get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 1/level_1.tscn")
