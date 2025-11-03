extends Control

const POPUP_NOME_SCENE = preload("res://Nos de Menu/Popup Nome/popup_nome.tscn")
const POPUP_SOBRE_SCENE = preload("res://Nos de Menu/Sobre/popup_sobre.tscn")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_button_pressed() -> void:
	audio_player.play()
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().quit()

@onready var anim = $Transicao/AnimationPlayer

func _on_start_pressed() -> void:
	audio_player.play()
	
	# Cria a instância da cena Popup
	
	var popup_nome = POPUP_NOME_SCENE.instantiate()
	
	# Conecta o sinal e vai para iniciar_jogo
	popup_nome.nome_confirmado.connect(_iniciar_jogo)
	add_child(popup_nome)
	popup_nome.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

func _on_relatorio_pressed() -> void:
	audio_player.play()
	get_tree().change_scene_to_file("res://Nos de Menu/Relatorio/tela_relatorio.tscn")

#chamada somente quando o popup emite o sinal
func _iniciar_jogo(nome_recebido: String) -> void:
	print("Nome confirmado: " + nome_recebido + ". Iniciando Fase 1...")
	audio_player.play()
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 1/level_1.tscn")
	
func _on_sobre_pressed() -> void:
	audio_player.play()
	var popup_sobre = POPUP_SOBRE_SCENE.instantiate()
	add_child(popup_sobre)
	popup_sobre.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
