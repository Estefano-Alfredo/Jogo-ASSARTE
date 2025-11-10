extends Node

var selecionado_1 := 0
var selecionado_2 := 0

# Variável para armazenar o nome do jogador
var nome_do_jogador: String = ""

var volume : float = 1.0
var volume_temp : float = 1.0

 # PONTUAÇÃO
var total_seconds : int = 0

# --- INÍCIO DAS NOVAS VARIÁVEIS DE RELATÓRIO ---
# Variáveis para a SESSÃO ATUAL
var erros_nivel_1_atual : int = 0
var tempo_restante_nivel_1_atual : int = 0
var erros_nivel_2_atual : int = 0
var tempo_restante_nivel_2_atual : int = 0

# Variável para guardar o último relatório calculado (para a tela final)
var ultimo_relatorio_calculado : Dictionary = {}

# Variável para guardar o histórico de todos os relatórios (para o educador)
var todos_os_relatorios : Array = []

# Caminho do arquivo para salvar os relatórios
const CAMINHO_SALVAR_RELATORIOS = "user://relatorios.dat"
# --- FIM DAS NOVAS VARIÁVEIS DE RELATÓRIO ---
# Caminho do arquivo para o educador (CSV)
const CAMINHO_CSV_EDUCADOR = "user://relatorio_educador.csv"

# Caminho do arquivo para salvar as regras
const CAMINHO_REGRAS_TXT = "res://regras_relatorio.txt"


# PONTUAÇÃO (Variáveis antigas, vamos usar as novas 'atuais' para o relatório)
var segundos_nivel_1 : int = 0 # Esta variável não estava sendo usada, vamos usar 'tempo_restante_nivel_1_atual'
var segundos_nivel_2 : int = 0 # Esta variável não estava sendo usada, vamos usar 'tempo_restante_nivel_2_atual'
var erros_nivel_2 : int = 0 # Vamos usar 'erros_nivel_2_atual'


# --- INÍCIO DAS NOVAS FUNÇÕES DE RELATÓRIO ---

# Função para limpar os dados da sessão atual (chamar ao iniciar o jogo)
func resetar_dados_sessao_atual():
	erros_nivel_1_atual = 0
	tempo_restante_nivel_1_atual = 0
	erros_nivel_2_atual = 0
	tempo_restante_nivel_2_atual = 0
	nome_do_jogador = ""
	ultimo_relatorio_calculado = {}

# Função para calcular o percentual e estrelas da Fase 1
func calcular_desempenho_fase_1(tempo_restante, erros):
	var tempo_max_f1 = 200.0 # Tempo original do contador da Fase 1 (3:20 ou 200s)
	var tempo_gasto = tempo_max_f1 - tempo_restante
	
	# Penalidade de tempo: 10% a cada 60 segundos gastos
	var penalidade_tempo = floor(tempo_gasto / 60.0) * 10.0
	
	# Penalidade de erro: 1% por erro
	var penalidade_erros = float(erros) * 1.0
	
	var percentual = 100.0 - penalidade_tempo - penalidade_erros
	percentual = max(0.0, percentual) # Garante que não seja negativo
	
	var estrelas = calcular_estrelas(percentual)
	
	return {"percentual": percentual, "estrelas": estrelas}

# Função para calcular o percentual e estrelas da Fase 2
func calcular_desempenho_fase_2(tempo_restante, erros):
	var tempo_max_f2 = 180.0 # Tempo original do contador da Fase 2 (3:00 ou 180s)
	var tempo_gasto = tempo_max_f2 - tempo_restante
	
	# Penalidade de tempo: 11% a cada 40 segundos gastos
	var penalidade_tempo = floor(tempo_gasto / 40.0) * 11.0
	
	# Penalidade de erro: 1% por erro (como definido para a F1)
	var penalidade_erros = float(erros) * 1.0
	
	var percentual = 100.0 - penalidade_tempo - penalidade_erros
	percentual = max(0.0, percentual) # Garante que não seja negativo
	
	var estrelas = calcular_estrelas(percentual)
	
	return {"percentual": percentual, "estrelas": estrelas}

# Função para converter percentual em estrelas, de acordo com sua regra
func calcular_estrelas(percentual):
	if percentual >= 90:
		return 5
	elif percentual >= 70:
		return 4
	elif percentual >= 60:
		return 3
	elif percentual >= 35:
		return 2
	else:
		return 1 # Inclui o 0%

# Função principal chamada ao final do jogo
func processar_e_salvar_relatorio_final():
	# 1. Calcular desempenhos
	var relatorio_f1 = calcular_desempenho_fase_1(tempo_restante_nivel_1_atual, erros_nivel_1_atual)
	var relatorio_f2 = calcular_desempenho_fase_2(tempo_restante_nivel_2_atual, erros_nivel_2_atual)
	
	# 2. Calcular média geral
	var perc_geral = (relatorio_f1.percentual + relatorio_f2.percentual) / 2.0
	var estrelas_geral = calcular_estrelas(perc_geral)
	
	# 3. Montar o dicionário de dados
	var relatorio_final = {
		"nome": nome_do_jogador,
		"data": Time.get_date_string_from_system() + " " + Time.get_time_string_from_system(),
		
		"fase1_percentual": relatorio_f1.percentual,
		"fase1_estrelas": relatorio_f1.estrelas,
		"fase1_erros": erros_nivel_1_atual,
		"fase1_tempo_restante": tempo_restante_nivel_1_atual,
		
		"fase2_percentual": relatorio_f2.percentual,
		"fase2_estrelas": relatorio_f2.estrelas,
		"fase2_erros": erros_nivel_2_atual,
		"fase2_tempo_restante": tempo_restante_nivel_2_atual,
		
		"geral_percentual": perc_geral,
		"geral_estrelas": estrelas_geral
	}
	
	# 4. Guardar para a tela final imediata
	ultimo_relatorio_calculado = relatorio_final
	
	# 5. Salvar no histórico
	carregar_relatorios_salvos() # Carrega o que já existe
	todos_os_relatorios.append(relatorio_final) # Adiciona o novo
	salvar_relatorios_no_arquivo() # Salva tudo de volta
	# Exporta o CSV para o educador
	exportar_para_csv(relatorio_final)
	# --- FIM DA MODIFICAÇÃO ---	
	print("Relatório salvo para: ", nome_do_jogador)

# Função para salvar o histórico no arquivo
func salvar_relatorios_no_arquivo():
	var file = FileAccess.open(CAMINHO_SALVAR_RELATORIOS, FileAccess.WRITE)
	if file:
		file.store_var(todos_os_relatorios)
		file.close()
	else:
		print("Erro ao tentar salvar o arquivo de relatórios.")

# Função para carregar o histórico do arquivo
func carregar_relatorios_salvos():
	if FileAccess.file_exists(CAMINHO_SALVAR_RELATORIOS):
		var file = FileAccess.open(CAMINHO_SALVAR_RELATORIOS, FileAccess.READ)
		if file:
			# Garante que o arquivo não está corrompido ou vazio
			if file.get_length() > 0:
				var data = file.get_var()
				if typeof(data) == TYPE_ARRAY:
					todos_os_relatorios = data
				else:
					print("Arquivo de relatório corrompido. Iniciando um novo.")
					todos_os_relatorios = []
			else:
				print("Arquivo de relatório vazio. Iniciando um novo.")
				todos_os_relatorios = []
			file.close()
		else:
			print("Erro ao tentar ler o arquivo de relatórios.")
			todos_os_relatorios = []
	else:
		print("Nenhum arquivo de relatório encontrado. Criando um novo.")
		todos_os_relatorios = []

# --- FIM DAS NOVAS FUNÇÕES DE RELATÓRIO ---

# --- INÍCIO DA FUNÇÃO DE EXPORTAÇÃO (EDUCADOR) - VERSÃO CORRIGIDA PARA GODOT 4 ---
func exportar_para_csv(relatorio_dict):
	_criar_arquivo_de_regras()
	var file_exists = FileAccess.file_exists(CAMINHO_CSV_EDUCADOR)
	
	var file # Declara a variável do arquivo
	
	if file_exists:
		# Se o arquivo existe, abre em modo de leitura/escrita (para não apagar o conteúdo)
		file = FileAccess.open(CAMINHO_CSV_EDUCADOR, FileAccess.ModeFlags.READ_WRITE)
	else:
		# Se o arquivo não existe, abre em modo de escrita (para criá-lo)
		file = FileAccess.open(CAMINHO_CSV_EDUCADOR, FileAccess.ModeFlags.WRITE)
		
	if file == null:
		print("Erro ao abrir o arquivo CSV do educador.")
		return

	# Se o arquivo não existia, escreve o cabeçalho (a primeira linha)
	if not file_exists:
		var header = "Nome,Data,F1_Percentual,F1_Estrelas,F1_Erros,F1_TempoRestante_s,F2_Percentual,F2_Estrelas,F2_Erros,F2_TempoRestante_s,Geral_Percentual,Geral_Estrelas\n"
		file.store_string(header)
	else:
		# Se o arquivo já existia, pulamos para o final dele antes de escrever
		file.seek_end() 
		
	# Formata a linha de dados (separada por vírgulas)
	var data_row = "%s,%s,%.2f,%d,%d,%d,%.2f,%d,%d,%d,%.2f,%d\n" % [
		relatorio_dict.nome,
		relatorio_dict.data,
		relatorio_dict.fase1_percentual,
		relatorio_dict.fase1_estrelas,
		relatorio_dict.fase1_erros,
		relatorio_dict.fase1_tempo_restante,
		relatorio_dict.fase2_percentual,
		relatorio_dict.fase2_estrelas,
		relatorio_dict.fase2_erros,
		relatorio_dict.fase2_tempo_restante,
		relatorio_dict.geral_percentual,
		relatorio_dict.geral_estrelas
	]
	
	# Salva a linha de dados no arquivo
	file.store_string(data_row)
	file.close()
	print("Relatório do Educador exportado para CSV.")
# --- FIM DA FUNÇÃO DE EXPORTAÇÃO ---

# --- INÍCIO DA NOVA FUNÇÃO (CRIAR ARQUIVO DE REGRAS) ---
func _criar_arquivo_de_regras():
	# Verifica se o arquivo já existe. Se sim, não faz nada.
	if FileAccess.file_exists(CAMINHO_REGRAS_TXT):
		return # Arquivo já existe.

	var file = FileAccess.open(CAMINHO_REGRAS_TXT, FileAccess.ModeFlags.WRITE)
	if file == null:
		print("Erro ao tentar criar o arquivo de regras.")
		return

	# Escreve o conteúdo explicativo
	file.store_string("PARÂMETROS DE AVALIAÇÃO - BIO-GEOMETRIA\n")
	file.store_string("==================================================\n\n")
	file.store_string("Este arquivo explica como o 'relatorio_educador.csv' é calculado.\n\n")
	
	file.store_string("--- REGRA DE ESTRELAS (GERAL) ---\n")
	file.store_string("5 Estrelas: 90-100% de aproveitamento\n")
	file.store_string("4 Estrelas: 70-89% de aproveitamento\n")
	file.store_string("3 Estrelas: 60-69% de aproveitamento\n")
	file.store_string("2 Estrelas: 35-59% de aproveitamento\n")
	file.store_string("1 Estrela:  0-34% de aproveitamento\n\n")

	file.store_string("--- FASE 1 (Puzzle Formas) ---\n")
	file.store_string("- Tempo Máximo: 200 segundos (3min 20s)\n")
	file.store_string("- Penalidade de Tempo: -10% de aproveitamento a cada 60 segundos gastos.\n")
	file.store_string("- Penalidade de Erro: -1% de aproveitamento por cada clique errado.\n\n")

	file.store_string("--- FASE 2 (Jogo da Memória) ---\n")
	file.store_string("- Tempo Máximo: 180 segundos (3min 00s)\n")
	file.store_string("- Penalidade de Tempo: -11% de aproveitamento a cada 40 segundos gastos.\n")
	file.store_string("- Penalidade de Erro: -1% de aproveitamento por cada par errado (Global.erros_nivel_2_atual).\n\n")
	
	file.close()
	print("Arquivo 'regras_relatorio.txt' criado com sucesso.")
# --- FIM DA NOVA FUNÇÃO ---
