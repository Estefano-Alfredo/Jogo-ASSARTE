extends Control

var config = ConfigFile.new()

@onready var anim := $Transicao/AnimationPlayer
@onready var v_box: VBoxContainer = $MarginContainer2/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/VBox
@onready var v_box_2: VBoxContainer = $MarginContainer2/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/VBox2
@onready var v_box_3: VBoxContainer = $MarginContainer2/VBoxContainer/MarginContainer/MarginContainer/HBoxContainer/VBox3

const ROTULO = preload("uid://bm0k17lnxsvu")

# função para voltar
func _on_voltar_pressed() -> void:
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://Nos de Menu/Menu/menu.tscn")

func _ready() -> void:
	
	var err := config.load("user://pontuacao.cfg")
	
	if err != OK:
		return
	
	for player in config.get_sections():
		# Fetch the data for each section.
		var nome = config.get_value(player, "player_name")
		var tempo = config.get_value(player, "player_time")
		var ponto = config.get_value(player, "player_ponto")
		
		var novo_fio := ROTULO.instantiate()
		v_box.add_child(novo_fio)
		novo_fio.text = nome
		
		var novo_fio_2 := ROTULO.instantiate()
		v_box_2.add_child(novo_fio_2)
		novo_fio_2.text = tempo
		
		var novo_fio_3 := ROTULO.instantiate()
		v_box_3.add_child(novo_fio_3)
		novo_fio_3.text = ponto
	
	
	var texto : String = config.encode_to_text()
	print(texto)


func _on_button_2_button_up() -> void:
	config.clear()
	config.save("user://pontuacao.cfg")
	anim.play("fade_in")
	await anim.animation_finished
	get_tree().reload_current_scene()
