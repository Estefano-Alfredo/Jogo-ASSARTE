extends Control

# Referência ao VBoxContainer que está dentro do ScrollContainer (que você acabou de criar)
@onready var container_lista: VBoxContainer = $MarginContainer/VBoxRelatorio/ScrollContainer/ListaDeRelatorios
# Carrega a fonte para usar nos labels
@onready var fonte_arcade = preload("res://Assets/Fontes/ARCADECLASSIC.TTF") 

func _ready():
	# Carrega todos os relatórios salvos do arquivo
	Global.carregar_relatorios_salvos()
	
	var relatorios = Global.todos_os_relatorios
	
	if relatorios.is_empty():
		# Mostra uma mensagem se não houver relatórios
		var label_vazio = Label.new()
		label_vazio.text = "Nenhum relatorio salvo ainda."
		label_vazio.set("theme_override_fonts/font", fonte_arcade)
		label_vazio.set("theme_override_font_sizes/font_size", 20)
		container_lista.add_child(label_vazio)
		return
		
	# Adiciona os cabeçalhos da lista
	container_lista.add_child(_criar_linha_relatorio("ALUNO", "DATA", "FASE 1", "FASE 2", "GERAL", true))
	
	# Itera sobre os relatórios salvos (do mais novo para o mais antigo)
	relatorios.reverse()
	for relatorio in relatorios:
		
		# Transforma o número de estrelas em texto (ex: 5 -> "*****")
		var f1_estrelas = _get_texto_estrelas(relatorio.fase1_estrelas)
		var f2_estrelas = _get_texto_estrelas(relatorio.fase2_estrelas)
		var geral_estrelas = _get_texto_estrelas(relatorio.geral_estrelas)
		
		# Cria a linha com os dados
		container_lista.add_child(_criar_linha_relatorio(relatorio.nome, relatorio.data, f1_estrelas, f2_estrelas, geral_estrelas, false))

# Função auxiliar para criar uma linha da tabela dinamicamente
func _criar_linha_relatorio(nome, data, f1, f2, geral, is_header=false):
	var hbox = HBoxContainer.new()
	hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	hbox.set("theme_override_constants/separation", 20) # Espaçamento entre colunas
	
	# Cria os labels para cada coluna
	var label_nome = _criar_label_coluna(nome, 250, is_header)
	var label_data = _criar_label_coluna(data, 300, is_header)
	var label_f1 = _criar_label_coluna(f1, 150, is_header)
	var label_f2 = _criar_label_coluna(f2, 150, is_header)
	var label_geral = _criar_label_coluna(geral, 150, is_header)
	
	# Adiciona os labels na linha
	hbox.add_child(label_nome)
	hbox.add_child(label_data)
	hbox.add_child(label_f1)
	hbox.add_child(label_f2)
	hbox.add_child(label_geral)
	
	return hbox

# Função auxiliar para configurar os labels de cada coluna
func _criar_label_coluna(texto, min_width, is_header):
	var label = Label.new()
	label.text = texto
	label.set_custom_minimum_size(Vector2(min_width, 0)) # Define largura mínima
	label.set("theme_override_fonts/font", fonte_arcade)
	label.set("theme_override_font_sizes/font_size", 30)
	
	if is_header:
		label.set("theme_override_colors/font_color", Color(1, 1, 0)) # Amarelo para cabeçalho
	else:
		label.set("theme_override_colors/font_color", Color(1, 1, 1)) # Branco para dados
		
	return label

# Função auxiliar para transformar o número de estrelas em texto
func _get_texto_estrelas(num_estrelas):
	var estrelas_texto = ""
	for i in num_estrelas:
		estrelas_texto += "*" # Adiciona um * para cada estrela
	return estrelas_texto

# função para voltar (original)
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")					
