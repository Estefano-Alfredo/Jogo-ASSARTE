extends Control

const POPUP_PAUSA_SCENE = preload("res://Nos de Menu/Botao Pausa/botao_pausa.tscn")
const MENU_PATH = "res://Nos de Menu/Menu/menu.tscn"



func _on_button_button_up() -> void:
	var popup_pausa = POPUP_PAUSA_SCENE.instantiate()
	
	# conecta o sinal de saida do popup à função de transição do nível
	popup_pausa.sair_pressionado.connect(_voltar_para_o_menu) 
	# adiciona o popup à árvore para que ele apareça e pause o jogo
	add_child(popup_pausa)

func _voltar_para_o_menu() -> void:
	# Usa a animação para o fade out
	var anim := $Transicao/AnimationPlayer
	$Transicao.visible = true
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file(MENU_PATH)
