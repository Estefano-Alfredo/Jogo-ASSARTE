extends Control
var count := 1
var cartas: Array = []
var acertos : int = 0
#const Carta = preload("uid://bfxmnen770jbj")

const POPUP_PAUSA_SCENE = preload("res://botao_pausa.tscn")
const MENU_PATH = "res://Nos de Menu/menu.tscn"

@onready var anim := $"../Transicao/AnimationPlayer"

func _init() -> void:
	pass

func _ready() -> void:
	var card_nodes = get_tree().get_nodes_in_group("Cards")
	count = card_nodes.size()
	@warning_ignore("integer_division")
	for i in range(count / 2):
		print("i:" + str(i))
		cartas.append(i+1)
		cartas.append(i+1)
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0
	cartas.shuffle()
	var i := 0
	for node in card_nodes:
		node.valor_da_carta = cartas[i]
		i = i + 1

func _on_carta_teste() -> void:
	var card_nodes = get_tree().get_nodes_in_group("Cards")
	
	if Global.selecionado_1 != Global.selecionado_2:
		await get_tree().create_timer(1.0).timeout
		Global.erros_nivel_2 += 1
		for node in card_nodes:
			if node.correto == false:
				if node.amostra:
					node.esconder_carta()
	else:
		acertos += 1
		for node in card_nodes:
			if node.amostra:
				node.correto = true
		if acertos == (count/2):
			await get_tree().create_timer(1.0).timeout
			anim.play("fade_in")
			await anim.animation_finished
			get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 3/Nivel 3.tscn")
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0

func _on_sair_pressed() -> void:
	var popup_pausa = POPUP_PAUSA_SCENE.instantiate()
	#conecta o sinal de do popup à função de transição
	popup_pausa.sair_pressionado.connect(_voltar_para_o_menu) 
	#adiciona o popup à árvore (isso vai pausar o jogo)
	add_child(popup_pausa)
	
func _voltar_para_o_menu() -> void:
	#anim.play("fade_in")
	#await anim.animation_finished
	get_tree().change_scene_to_file(MENU_PATH)
