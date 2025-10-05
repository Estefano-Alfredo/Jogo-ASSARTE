extends Control

# Variável para a caixa de texto
@onready var line_edit_nome: LineEdit = $Panel/MarginContainer/VBoxContainer/LineEdit 
@onready var panel_popup: Panel = $Panel
@onready var color_rect_fundo: ColorRect = $ColorRect

# sinal que será emitido quando o nome for confirmado
signal nome_confirmado(nome: String)

func _ready():
	# layout
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)	# faz a raiz preencher a tela inteira
	color_rect_fundo.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)	# fundo escuro cobrir a tela inteira
	
	# define o tamanho desejado para a caixa cinza do popup
	var popup_width = 500
	var popup_height = 250
	
	# centraliza o panel na tela
	var viewport_size = get_viewport_rect().size
	panel_popup.size = Vector2(popup_width, popup_height)
	panel_popup.position = (viewport_size / 2) - (panel_popup.size / 2)
	
	# faz container internos se ajustarem 
	$Panel/MarginContainer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	$Panel/MarginContainer/VBoxContainer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
	# fz a conexão de sinal
	line_edit_nome.text_submitted.connect(_on_button_pressed)
	# define o foco no campo de texto para o jogador começar a digitar de imediato
	line_edit_nome.grab_focus()
	
func _on_button_pressed(_new_text = "") -> void:
	# pega o texto e remove espaços extras
	var nome = line_edit_nome.text.strip_edges()
	
	if nome.is_empty():
		print("Por favor, digite um nome.")
		return
	
	# salva o nome na variável global
	Global.nome_do_jogador = nome 
	print("Nome do jogador salvo: " + Global.nome_do_jogador)
	
	# emite o sinal de confirmação
	nome_confirmado.emit(nome)
	
	# remove o nó Popup da cena
	queue_free()
	
	
	
