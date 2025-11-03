extends Control
var ameixa = ConfigFile.new()

# função para voltar
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/Menu/menu.tscn")

func _ready() -> void:
	
	ameixa.load("user://pontuacao.cfg")
	var texto : String = ameixa.encode_to_text()
	
	print(texto)
