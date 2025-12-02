extends Control

# Caminhos corretos para os nós da cena relatorio_final.tscn
@onready var label_nome_jogador: Label = $CenterContainer/VBoxContainer/LabelNomeJogador

@onready var estrelas_fase_1: HBoxContainer = $CenterContainer/VBoxContainer/EstrelasConteiner
@onready var estrelas_fase_2: HBoxContainer = $CenterContainer/VBoxContainer/EstrelasConteiner2
@onready var estrelas_fase_3: HBoxContainer = $CenterContainer/VBoxContainer/EstrelasConteiner3
@onready var estrelas_geral: HBoxContainer = $CenterContainer/VBoxContainer/EstrelasConteiner4

func _ready():
	# Pega o dicionário do último relatório que foi salvo no Global
	var relatorio = Global.ultimo_relatorio_calculado
	
	if relatorio.is_empty():
		label_nome_jogador.text = "Erro: Relatorio nao foi processado."
		return
	
	# Popula os labels com os dados do relatório
	label_nome_jogador.text = "Desempenho de -> %s" % relatorio.nome
	print(relatorio.fase1_estrelas)
	_get_texto_estrelas(relatorio.fase1_estrelas, estrelas_fase_1)
	_get_texto_estrelas(relatorio.fase2_estrelas, estrelas_fase_2)
	_get_texto_estrelas(relatorio.fase3_estrelas, estrelas_fase_3)
	_get_texto_estrelas(relatorio.geral_estrelas, estrelas_geral)

# Função auxiliar para transformar o número de estrelas em texto
func _get_texto_estrelas(num_estrelas : int, no : HBoxContainer):
	#var estrelas_texto = ""
	for i in num_estrelas:
		var estrela = no.get_child(i)
		estrela.visible = true
		#estrelas_texto += "*" # Adiciona um * para cada estrela

# Conexão do botão "Voltar ao Menu"
func _on_voltarao_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")
