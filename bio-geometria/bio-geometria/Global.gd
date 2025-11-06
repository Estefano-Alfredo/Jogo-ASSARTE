extends Node

var volume : float = 1.0
var volume_temp : float = 1.0

var selecionado_1 := 0
var selecionado_2 := 0

# Variável para armazenar o nome do jogador
var nome_do_jogador: String = ""

 # PONTUAÇÃO
var total_seconds : int = 0
var segundos_nivel_1 : int = 0
var segundos_nivel_2 : int = 0
var erros_nivel_2 : int = 0


func salvar_tempo(nivel : String, segundos):
	var config = ConfigFile.new()
	var err = config.load("user://pontuacao.cfg")
	if err != OK:
		print("Arquivo não encontrado")
		return
	var salvo := false
	for player in config.get_sections(): # Roda cada seção no arquivo
		var player_name = config.get_value(player, "player_name")
		if player_name == nome_do_jogador:
			salvo = true
			var tempo_temp := processar_tempo()
			config.set_value(player, "player_time", tempo_temp)
			config.set_value(player, nivel, segundos)
	if not salvo:
		print("Usuario não encontrado")
	config.save("user://pontuacao.cfg")

func processar_tempo() -> String:
	@warning_ignore("integer_division")
	var tempo_temp : int = (total_seconds / 60)
	
	var seg_temp : String
	if tempo_temp < 10:
		seg_temp = "0" + str(tempo_temp)
	else:
		seg_temp = str(tempo_temp)
	
	tempo_temp = (total_seconds % 60)
	
	var min_temp : String
	if (tempo_temp) < 10:
		min_temp = "0" + str(tempo_temp)
	else:
		min_temp = str(tempo_temp)
	
	return (seg_temp + ":" + min_temp)
