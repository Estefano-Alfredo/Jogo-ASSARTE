extends Control

# Nós da sua cena
@onready var label_nome: Label = $CenterContainer/VBoxContainer/LabelNomeJogador
@onready var label_estrelas_f1: Label = $CenterContainer/VBoxContainer/EstrelasFase1
@onready var label_estrelas_f2: Label = $CenterContainer/VBoxContainer/EstrelasFase2
@onready var label_estrelas_geral: Label = $CenterContainer/VBoxContainer/EstrelasGeral
@onready var botao_voltar: Button = $CenterContainer/VBoxContainer/VoltaraoMenu

# --- (Opcional) Fonte personalizada ---
@onready var fonte_arcade = preload("res://Assets/Fontes/ARCADECLASSIC.TTF")

# --- TAMANHO ÚNICO DA FONTE (mude só aqui!) ---
const TAMANHO_FONTE = 50


func _ready():
	# --- Garante que o botão esteja conectado ---
	if not botao_voltar.is_connected("pressed", Callable(self, "_on_voltarao_menu_pressed")):
		botao_voltar.pressed.connect(_on_voltarao_menu_pressed)

	# --- Aplica o mesmo tamanho de fonte para todos ---
	_aplicar_tamanho_fonte(label_nome, TAMANHO_FONTE)
	_aplicar_tamanho_fonte(label_estrelas_f1, TAMANHO_FONTE)
	_aplicar_tamanho_fonte(label_estrelas_f2, TAMANHO_FONTE)
	_aplicar_tamanho_fonte(label_estrelas_geral, TAMANHO_FONTE)
	_aplicar_tamanho_fonte(botao_voltar, TAMANHO_FONTE)

	# --- Carrega o relatório final ---
	var relatorio = Global.ultimo_relatorio_calculado
	
	if relatorio.is_empty():
		print("ERRO: O relatorio final estava vazio. Os dados não foram calculados.")
		label_nome.text = "ERRO AO CARREGAR DADOS"
		label_estrelas_f1.text = "Erro"
		label_estrelas_f2.text = "Erro"
		label_estrelas_geral.text = "Erro"
		return
		
	# --- Exibe os dados ---
	label_nome.text = "Desempenho de: " + relatorio.nome
	label_estrelas_f1.text = _get_texto_estrelas(relatorio.fase1_estrelas)
	label_estrelas_f2.text = _get_texto_estrelas(relatorio.fase2_estrelas)
	label_estrelas_geral.text = _get_texto_estrelas(relatorio.geral_estrelas)


# Função para aplicar o tamanho da fonte
func _aplicar_tamanho_fonte(control: Control, tamanho: int):
	if fonte_arcade:
		control.add_theme_font_override("font", fonte_arcade)
	control.add_theme_font_size_override("font_size", tamanho)


# Função helper para transformar o número de estrelas em texto
func _get_texto_estrelas(num_estrelas):
	var estrelas_texto = ""
	for i in num_estrelas:
		estrelas_texto += "*"
	return estrelas_texto


# Função do botão
func _on_voltarao_menu_pressed():
	print("Botão 'Voltar ao Menu' pressionado. Indo para o menu.")
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")
