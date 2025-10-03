extends Control

var selecao := ""
var selecao2 := "0"
#
# 0 - Nada
# 1 - Triangulo
# 2 - Quadrado
#
const ICON = preload("uid://c33p2dnbv3brm")

const SEMICIRCULO = preload("uid://hnak7rafjwog")
const QUADRADO = preload("uid://153sobfftdgc")
const TRIANGULO = preload("uid://bqmqw7x1tuo6h")

func _on_triangulo_pressed() -> void:
	selecao = "Triangulo"
	Input.set_custom_mouse_cursor(TRIANGULO, Input.CURSOR_ARROW, Vector2(25,50))
	botao_pressionado()


func _on_quadrado_pressed() -> void:
	selecao = "Quadrado"
	Input.set_custom_mouse_cursor(QUADRADO, Input.CURSOR_ARROW, Vector2(64,64))
	botao_pressionado()


func _on_semicirculo_pressed() -> void:
	selecao = "Semicírculo"
	Input.set_custom_mouse_cursor(SEMICIRCULO, Input.CURSOR_ARROW, Vector2(25,50))
	botao_pressionado()

func botao_pressionado() -> void:
	pass
	#print("Voce selecionou um "+selecao)


# Resposta
@onready var button: Button = $GridContainer/Button
@onready var button_2: Button = $GridContainer/Button2
@onready var button_3: Button = $GridContainer/Button3


func _on_button_pressed() -> void:
	selecao2 = "Semicírculo"
	var res = resposta_selecionada()
	if res == true:
		button.text = ""
		button.icon = SEMICIRCULO
	
func _on_button_2_pressed() -> void:
	selecao2 = "Quadrado"
	var res = resposta_selecionada()
	if res == true:
		button_2.text = ""
		button_2.icon = QUADRADO

func resposta_selecionada() -> bool:
	#print("Voce selecionou um " + selecao2)
	
	if selecao == selecao2:
		print("Resposta Correta")
		Input.set_custom_mouse_cursor(null)
		return true
	else:
		print("Resposta Incorreta")
		return false


func _on_button_3_pressed() -> void:
	selecao2 = "Triangulo"
	var res = resposta_selecionada()
	if res == true:
		button_3.text = ""
		button_3.icon = TRIANGULO
