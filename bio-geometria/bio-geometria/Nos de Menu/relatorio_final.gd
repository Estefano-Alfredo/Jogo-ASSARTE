extends Control

# Nós da sua cena (que acabamos de criar)
@onready var label_nome: Label = $CenterContainer/VBoxContainer/LabelNomeJogador
@onready var label_estrelas_f1: Label = $CenterContainer/VBoxContainer/EstrelasFase1
@onready var label_estrelas_f2: Label = $CenterContainer/VBoxContainer/EstrelasFase2
# --- INÍCIO DA MODIFICAÇÃO (Fase 3) ---
@onready var label_estrelas_f3: Label = $CenterContainer/VBoxContainer/EstrelasFase3
# --- FIM DA MODIFICAÇÃO ---
@onready var label_estrelas_geral: Label = $CenterContainer/VBoxContainer/EstrelasGeral
@onready var botao_voltar: Button = $CenterContainer/VBoxContainer/VoltaraoMenu


func _ready():
	# Garante que o botão esteja conectado, mesmo que falhe pelo editor
	if not botao_voltar.is_connected("pressed", Callable(self, "_on_voltarao_menu_pressed")): 
		botao_voltar.pressed.connect(_on_voltarao_menu_pressed) 

	# Pega o relatório que o Global.gd acabou de calcular
	var relatorio = Global.ultimo_relatorio_calculado
	
	if relatorio.is_empty():
		print("ERRO: O relatorio final estava vazio. Os dados não foram calculados.")
		label_nome.text = "ERRO AO CARREGAR DADOS"
		label_estrelas_f1.text = "Erro"
		label_estrelas_f2.text = "Erro"
		# --- INÍCIO DA MODIFICAÇÃO (Fase 3) ---
		label_estrelas_f3.text = "Erro"
		# --- FIM DA MODIFICAÇÃO ---
		label_estrelas_geral.text = "Erro"
		return
		
	# Exibe o nome
	label_nome.text = "Desempenho de: " + relatorio.nome
	
	# Exibe as estrelas
	label_estrelas_f1.text = _get_texto_estrelas(relatorio.fase1_estrelas)
	label_estrelas_f2.text = _get_texto_estrelas(relatorio.fase2_estrelas)
	# --- INÍCIO DA MODIFICAÇÃO (Fase 3) ---
	label_estrelas_f3.text = _get_texto_estrelas(relatorio.fase3_estrelas)
	# --- FIM DA MODIFICAÇÃO ---
	label_estrelas_geral.text = _get_texto_estrelas(relatorio.geral_estrelas)


# Função helper para transformar o número de estrelas em texto
func _get_texto_estrelas(num_estrelas):
	var estrelas_texto = ""
	for i in num_estrelas:
		estrelas_texto += "*" # Adiciona uma estrela
	return estrelas_texto


# Esta função será conectada pelo editor
func _on_voltarao_menu_pressed():
	print("Botão 'Voltar ao Menu' pressionado. Indo para o menu.")
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")
