extends Node

var selecionado_1 := 0
var selecionado_2 := 0

# Variável para armazenar o nome do jogador
var nome_do_jogador: String = ""

var volume : float = 1.0
var volume_temp : float = 1.0

 # PONTUAÇÃO
var total_seconds : int = 0

var segundos_nivel_1 : int = 0

var segundos_nivel_2 : int = 0
var erros_nivel_2 : int = 0

func salvar_tempo():
	var config = ConfigFile.new()
	var err = config.load("user://pontuacao.cfg")
	if err != OK:
		print("Arquivo não encontrado")
		return
	var salvo := false
	for player in config.get_sections(): # Roda cada seção no arquivo
		var player_name = config.get_value(player, "player_name")
		if player_name == Global.nome_do_jogador:
			salvo = true
			var seg_temp : String
			@warning_ignore("integer_division")
			if (Global.total_seconds / 60) < 10:
				@warning_ignore("integer_division")
				seg_temp = "0" + str(Global.total_seconds / 60)
			else:
				@warning_ignore("integer_division")
				seg_temp = str(Global.total_seconds / 60)
			var min_temp : String
			if (Global.total_seconds % 60) < 10:
				min_temp = "0" + str(Global.total_seconds % 60)
			else:
				min_temp = str(Global.total_seconds % 60)
			var tempo_temp := seg_temp + ":" + min_temp
			config.set_value(player, "player_time", tempo_temp)
	if not salvo:
		print("Usuario não encontrado")
	config.save("user://pontuacao.cfg")
