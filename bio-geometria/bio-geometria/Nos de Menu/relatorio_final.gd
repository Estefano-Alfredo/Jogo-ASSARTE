extends Control

# Caminhos corretos para os nós da cena relatorio_final.tscn
@onready var label_nome_jogador: Label = $CenterContainer/VBoxContainer/LabelNomeJogador
@onready var estrelas_fase_1: Label = $CenterContainer/VBoxContainer/EstrelasFase1
@onready var estrelas_fase_2: Label = $CenterContainer/VBoxContainer/EstrelasFase2
@onready var estrelas_fase_3: Label = $CenterContainer/VBoxContainer/EstrelasFase3
@onready var estrelas_geral: Label = $CenterContainer/VBoxContainer/EstrelasGeral

func _ready():
	# Pega o dicionário do último relatório que foi salvo no Global
	var relatorio = Global.ultimo_relatorio_calculado
	
	if relatorio.is_empty():
		label_nome_jogador.text = "Erro: Relatorio nao foi processado."
		return
	
	# Popula os labels com os dados do relatório
	label_nome_jogador.text = "Desempenho de -> %s" % relatorio.nome
	estrelas_fase_1.text = _get_texto_estrelas(relatorio.fase1_estrelas)
	estrelas_fase_2.text = _get_texto_estrelas(relatorio.fase2_estrelas)
	estrelas_fase_3.text = _get_texto_estrelas(relatorio.fase3_estrelas)
	estrelas_geral.text = _get_texto_estrelas(relatorio.geral_estrelas)

# Função auxiliar para transformar o número de estrelas em texto
func _get_texto_estrelas(num_estrelas):
	var estrelas_texto = ""
	for i in num_estrelas:
		estrelas_texto += "*" # Adiciona um * para cada estrela
	return estrelas_texto

# Conexão do botão "Voltar ao Menu"
func _on_voltarao_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")
