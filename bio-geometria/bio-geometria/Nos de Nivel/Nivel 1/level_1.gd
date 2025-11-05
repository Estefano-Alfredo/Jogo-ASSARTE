extends Control

@onready var contador: Control = $Contador

var config = ConfigFile.new()
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

const POPUP_PAUSA_SCENE = preload("res://Nos de Menu/Botao Pausa/botao_pausa.tscn")
const MENU_PATH = "res://Nos de Menu/Menu/menu.tscn"

@onready var esc_triangulo: Button = $MarginContainer/VBoxContainer/Triangulo
@onready var esc_quadrado: Button = $MarginContainer/VBoxContainer/Quadrado
@onready var esc_semicirculo: Button = $MarginContainer/VBoxContainer/Semicirculo
@onready var anim := $Transicao/AnimationPlayer

func _on_triangulo_pressed() -> void:
	if esc_triangulo.x == false:
		botao_pressionado("Triangulo", TRIANGULO, 25, 50)


func _on_quadrado_pressed() -> void:
	if esc_quadrado.x == false:
		botao_pressionado("Quadrado", QUADRADO, 50, 50)


func _on_semicirculo_pressed() -> void:
	if esc_semicirculo.x == false:
		botao_pressionado("Semicírculo", SEMICIRCULO, 25, 50)

func botao_pressionado(formato, formato2, x , y) -> void:
	selecao = formato
	Input.set_custom_mouse_cursor(formato2, Input.CURSOR_ARROW, Vector2(x,y))


# Resposta
@onready var button: Button = $GridContainer/Button
@onready var button_2: Button = $GridContainer/Button2
@onready var button_3: Button = $GridContainer/Button3


func _on_button_pressed() -> void:
	selecao2 = "Semicírculo"
	resposta_selecionada(button ,SEMICIRCULO, esc_semicirculo)

func _on_button_2_pressed() -> void:
	selecao2 = "Quadrado"
	resposta_selecionada(button_2, QUADRADO, esc_quadrado)

func _on_button_3_pressed() -> void:
	selecao2 = "Triangulo"
	resposta_selecionada(button_3, TRIANGULO, esc_triangulo)

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
			contador.ligado = false
			
			Global.salvar_tempo()
			
			anim.play("fade_in")
			await anim.animation_finished
			get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 2/nivel_2.tscn")
	else:
		print("Resposta Incorreta")

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
