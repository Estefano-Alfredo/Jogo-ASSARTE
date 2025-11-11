extends Control

@onready var contador: Control = $Contador

var selecao := ""
var selecao2 := ""
var progresso := 0
#
# 0 - Nada
# 1 - Triangulo
# 2 - Quadrado
#
const ICON = preload("uid://c33p2dnbv3brm")

const SEMICIRCULO = preload("uid://hnak7rafjwog")
const QUADRADO = preload("uid://153sobfftdgc")
const TRIANGULO = preload("uid://bqmqw7x1tuo6h")

const POPUP_PAUSA_SCENE = preload("res://Nos de Menu/botao_pausa.tscn")
const MENU_PATH = "res://Nos de Menu/menu.tscn"
const POPUP_INFO_SCENE = preload("res://Nos/popup_info_animal.tscn")

@export_multiline var TEXTO_ANIMAL_1: String = "" #abelha
@export_multiline var TEXTO_ANIMAL_2: String = "" #arara

@onready var esc_triangulo: Button = $MarginContainer/VBoxContainer/Triangulo
@onready var esc_quadrado: Button = $MarginContainer/VBoxContainer/Quadrado
@onready var esc_semicirculo: Button = $MarginContainer/VBoxContainer/Semicirculo

@onready var anim := $Transicao/AnimationPlayer

const ABELHA_C = preload("uid://cm187nssvpkkb")
const ABELHA_2 = preload("uid://ddpjo3jm7q3ob")
const ABELHA_3 = preload("uid://b1qks0t1jlg7k")

const ARARA_AZUL_2 = preload("uid://db4jawaghemuo")
const ARARA_AZUL_C = preload("uid://c1d8xfmq640eb")
const ARARA_AZUL_3 = preload("uid://d2ymiehsy6sws")

#const TARTARUGA_C = preload("uid://bv8uyxxhpgjf5")
#const TARTARUGA_2 = preload("uid://cxehe7nva62wa")
#const TARTARUGA_3 = preload("uid://cw8utm04duasu")

const ARARA_QUADRADO_SOMBRA = preload("uid://cj00wa21paj3l")
const ARARA_SEMICIRCULO_SOMBRA = preload("uid://kwyi70tr276k")
const ARARA_TRIANGULO_SOMBRA = preload("uid://dsa71uhdcdjsa")

var a1 : CompressedTexture2D
var a2 : CompressedTexture2D
var a3 : CompressedTexture2D
func _ready() -> void:
	match Global.progreso_nivel_1:
		1:
			a1 = ABELHA_C
			a2 = ABELHA_2
			a3 = ABELHA_3
		2:
			a1 = ARARA_AZUL_C
			a2 = ARARA_AZUL_2
			a3 = ARARA_AZUL_3
			button.icon = ARARA_SEMICIRCULO_SOMBRA
			button_2.icon = ARARA_QUADRADO_SOMBRA
			button_3.icon = ARARA_TRIANGULO_SOMBRA
		#3:
			#a1 = TARTARUGA_C
			#a2 = TARTARUGA_2
			#a3 = TARTARUGA_3
	esc_triangulo.icon = a3
	esc_quadrado.icon = a2
	esc_semicirculo.icon = a1

func _on_triangulo_pressed() -> void:
	if esc_triangulo.x == false:
		botao_pressionado("Triangulo", a3, 71, 125)


func _on_quadrado_pressed() -> void:
	if esc_quadrado.x == false:
		botao_pressionado("Quadrado", a2, 68, 125)


func _on_semicirculo_pressed() -> void:
	if esc_semicirculo.x == false:
		botao_pressionado("Semicírculo", a1, 84, 125)

func botao_pressionado(formato, formato2, x , y) -> void:
	selecao = formato
	Input.set_custom_mouse_cursor(formato2, Input.CURSOR_ARROW, Vector2(x,y))


# Resposta
@onready var button: Button = $GridContainer/Button
@onready var button_2: Button = $GridContainer/Button2
@onready var button_3: Button = $GridContainer/Button3



func _on_button_pressed() -> void:
	selecao2 = "Semicírculo"
	resposta_selecionada(button ,a1, esc_semicirculo)

func _on_button_2_pressed() -> void:
	selecao2 = "Quadrado"
	resposta_selecionada(button_2, a2, esc_quadrado)

func _on_button_3_pressed() -> void:
	selecao2 = "Triangulo"
	resposta_selecionada(button_3, a3, esc_triangulo)

func resposta_selecionada(botao, forma, botao2) -> void:
	#print("Voce selecionou um " + selecao2)
	if selecao == selecao2:
		progresso += 1
		botao.text = ""
		botao.icon = forma
		print("Resposta Correta")
		Input.set_custom_mouse_cursor(null)
		botao2.x = true
		selecao = ""
		selecao2 = ""
		if progresso >= 3:
			# --- INÍCIO DA MODIFICAÇÃO de relatorio ---
			# Para o contador e salva o tempo restante
			contador.ligado = false
			Global.tempo_restante_nivel_1_atual = contador.tempo
			
			var popup = POPUP_INFO_SCENE.instantiate() # aqui to mundando pro popup dos textos
			var texto_para_mostrar = ""
			match Global.progreso_nivel_1:
				1:
					texto_para_mostrar = TEXTO_ANIMAL_1
				2:
					texto_para_mostrar =  TEXTO_ANIMAL_2
			add_child(popup)
			popup.set_text(texto_para_mostrar)
			await popup.popup_fechado
			
			print("Fase 1 completa. Erros: ", Global.erros_nivel_1_atual, " Tempo Restante: ", Global.tempo_restante_nivel_1_atual)
			# --- FIM DA MODIFICAÇÃO ---
			
			anim.play("fade_in")
			await anim.animation_finished
			if Global.progreso_nivel_1 == 1:
				Global.progreso_nivel_1 = 2
				get_tree().reload_current_scene()
			else:
				Global.progreso_nivel_1 = 1
				get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 2/nivel_2.tscn")
	else:
		print("Resposta Incorreta")
		# --- INÍCIO DA MODIFICAÇÃO de relatorio ---
		# Registra o erro na variável global
		Global.erros_nivel_1_atual += 1
		print("Erros Nível 1: ", Global.erros_nivel_1_atual)
		# --- FIM DA MODIFICAÇÃO ---


func _on_sair_pressed() -> void:
	var popup_pausa = POPUP_PAUSA_SCENE.instantiate()
	
	# conecta o sinal de saida do popup à função de transição do nível
	popup_pausa.sair_pressionado.connect(_voltar_para_o_menu) 
	# adiciona o popup à árvore para que ele apareça e pause o jogo
	add_child(popup_pausa)
	
func _voltar_para_o_menu() -> void:
	# Usa a animação para o fade out
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file(MENU_PATH)
