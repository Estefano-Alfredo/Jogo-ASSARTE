extends Node

var selecionado_1 := 0
var selecionado_2 := 0

var progreso_nivel_1 := 1
var nome_do_jogador: String = ""
var volume : float = 1.0
var volume_temp : float = 1.0
var total_seconds : int = 0

var erros_nivel_1_atual : int = 0
var tempo_restante_nivel_1_atual : int = 0
var erros_nivel_2_atual : int = 0
var tempo_restante_nivel_2_atual : int = 0

var ultimo_relatorio_calculado : Dictionary = {}
var todos_os_relatorios : Array = []

var CAMINHO_SALVAR_RELATORIOS : String
var CAMINHO_CSV_EDUCADOR : String
var CAMINHO_REGRAS_TXT : String


# --- CONFIGURAÇÃO DO LOCAL DE SALVAMENTO ---
func _ready():
	# Obtém o caminho da pasta "Documentos" do usuário atual
	var pasta_documentos = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
	
	# Cria (ou usa) a pasta "Jogo" dentro de Documentos
	var pasta_jogo = pasta_documentos.path_join("Jogo")
	
	# Garante que a pasta exista
	if not DirAccess.dir_exists_absolute(pasta_jogo):
		DirAccess.make_dir_recursive_absolute(pasta_jogo)
	
	# Define os caminhos de salvamento
	CAMINHO_SALVAR_RELATORIOS = pasta_jogo.path_join("relatorios.dat")
	CAMINHO_CSV_EDUCADOR = pasta_jogo.path_join("relatorio_educador.csv")
	CAMINHO_REGRAS_TXT = pasta_jogo.path_join("regras_relatorio.txt")
	
	print("Relatórios serão salvos em: ", pasta_jogo)
# ----------------------------------------------------


func resetar_dados_sessao_atual():
	erros_nivel_1_atual = 0
	tempo_restante_nivel_1_atual = 0
	erros_nivel_2_atual = 0
	tempo_restante_nivel_2_atual = 0
	nome_do_jogador = ""
	ultimo_relatorio_calculado = {}


func calcular_desempenho_fase_1(tempo_restante, erros):
	var tempo_max_f1 = 200.0
	var tempo_gasto = tempo_max_f1 - tempo_restante
	var penalidade_tempo = floor(tempo_gasto / 60.0) * 10.0
	var penalidade_erros = float(erros) * 1.0
	var percentual = 100.0 - penalidade_tempo - penalidade_erros
	percentual = max(0.0, percentual)
	var estrelas = calcular_estrelas(percentual)
	return {"percentual": percentual, "estrelas": estrelas}


func calcular_desempenho_fase_2(tempo_restante, erros):
	var tempo_max_f2 = 180.0
	var tempo_gasto = tempo_max_f2 - tempo_restante
	var penalidade_tempo = floor(tempo_gasto / 40.0) * 11.0
	var penalidade_erros = float(erros) * 1.0
	var percentual = 100.0 - penalidade_tempo - penalidade_erros
	percentual = max(0.0, percentual)
	var estrelas = calcular_estrelas(percentual)
	return {"percentual": percentual, "estrelas": estrelas}


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
		return 1


func processar_e_salvar_relatorio_final():
	var relatorio_f1 = calcular_desempenho_fase_1(tempo_restante_nivel_1_atual, erros_nivel_1_atual)
	var relatorio_f2 = calcular_desempenho_fase_2(tempo_restante_nivel_2_atual, erros_nivel_2_atual)
	var perc_geral = (relatorio_f1.percentual + relatorio_f2.percentual) / 2.0
	var estrelas_geral = calcular_estrelas(perc_geral)
	
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
	
	ultimo_relatorio_calculado = relatorio_final
	carregar_relatorios_salvos()
	todos_os_relatorios.append(relatorio_final)
	salvar_relatorios_no_arquivo()
	exportar_para_csv(relatorio_final)
	print("Relatório salvo para: ", nome_do_jogador)


func salvar_relatorios_no_arquivo():
	var file = FileAccess.open(CAMINHO_SALVAR_RELATORIOS, FileAccess.WRITE)
	if file:
		file.store_var(todos_os_relatorios)
		file.close()
	else:
		print("Erro ao tentar salvar o arquivo de relatórios.")


func carregar_relatorios_salvos():
	if FileAccess.file_exists(CAMINHO_SALVAR_RELATORIOS):
		var file = FileAccess.open(CAMINHO_SALVAR_RELATORIOS, FileAccess.READ)
		if file:
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


func exportar_para_csv(relatorio_dict):
	_criar_arquivo_de_regras()
	var file_exists = FileAccess.file_exists(CAMINHO_CSV_EDUCADOR)
	var file
	if file_exists:
		file = FileAccess.open(CAMINHO_CSV_EDUCADOR, FileAccess.ModeFlags.READ_WRITE)
	else:
		file = FileAccess.open(CAMINHO_CSV_EDUCADOR, FileAccess.ModeFlags.WRITE)
	if file == null:
		print("Erro ao abrir o arquivo CSV do educador.")
		return
	if not file_exists:
		var header = "Nome,Data,F1_Percentual,F1_Estrelas,F1_Erros,F1_TempoRestante_s,F2_Percentual,F2_Estrelas,F2_Erros,F2_TempoRestante_s,Geral_Percentual,Geral_Estrelas\n"
		file.store_string(header)
	else:
		file.seek_end()
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
	file.store_string(data_row)
	file.close()
	print("Relatório do Educador exportado para CSV.")


func _criar_arquivo_de_regras():
	if FileAccess.file_exists(CAMINHO_REGRAS_TXT):
		return
	var file = FileAccess.open(CAMINHO_REGRAS_TXT, FileAccess.ModeFlags.WRITE)
	if file == null:
		print("Erro ao tentar criar o arquivo de regras.")
		return
	file.store_string("PARÂMETROS DE AVALIAÇÃO - BIO-GEOMETRIA\n")
	file.store_string("==================================================\n\n")
	file.store_string("Este arquivo explica como o 'relatorio_educador.csv' é calculado.\n\n")
	file.store_string("--- REGRA DE ESTRELAS (GERAL) ---\n")
	file.store_string("5 Estrelas: 90-100% de aproveitamento\n")
	file.store_string("4 Estrelas: 70-89% de aproveitamento\n")
	file.store_string("3 Estrelas: 60-69% de aproveitamento\n")
	file.store_string("2 Estrelas: 35-59% de aproveitamento\n")
	file.store_string("1 Estrela: 0-34% de aproveitamento\n\n")
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
