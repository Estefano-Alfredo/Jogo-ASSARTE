extends Control

@onready var enunciado: Label = $"Margem de Fora/VBoxContainer/Pergunta"
@onready var resposta_1: Button = $"Margem de Fora/VBoxContainer/HBoxContainer/Resposta 1"
@onready var resposta_2: Button = $"Margem de Fora/VBoxContainer/HBoxContainer/Resposta 2"

var num_pergunta := 1 # Armazena o numro da pergunta

func _init() -> void:
	Global.selecionado_1 = 0

var pergunta := ""
var resposta_correta := ""
var resposta_errada := ""

func _ready() -> void:
	
	var x := randi_range(0,1)
	match num_pergunta:
		1: # Primeira pergunta
			pergunta = "Qual o resultado de 2 + 2?"
			resposta_correta = "4"
			resposta_errada = "5"
			
		2: # Segunda pergunta
			pergunta = "Enunciado 2"
			resposta_correta = "Resposta 2 Correta"
			resposta_errada = "Resposta 2 Errada"
		
		3: # Modelo de pergunta
			pergunta = "Enunciado 3"
			resposta_correta = "Resposta 3 Correta"
			resposta_errada = "Resposta 3 Errada"
	
	if x == 0:
		atualiza_pergunta(pergunta, resposta_correta, resposta_errada)
		resposta_1.resposta = 1
		resposta_2.resposta = 0
	else:
		atualiza_pergunta(pergunta, resposta_errada, resposta_correta)
		resposta_1.resposta = 0
		resposta_2.resposta = 1

func _on_resposta_1_resposta_selecionada() -> void:
	if Global.selecionado_1 == 1:
		Global.selecionado_1 = 0
		num_pergunta += 1
		_ready()
		print("Correto!")
	else:
		print("ERROU!")


func atualiza_pergunta(e : String, r1 : String, r2 : String):
	enunciado.text = e
	resposta_1.text = r1
	resposta_2.text = r2
