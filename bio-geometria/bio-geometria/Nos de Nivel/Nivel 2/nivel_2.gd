extends Control
var count := 1
var cartas: Array = []
var acertos : int = 0
#const Carta = preload("uid://bfxmnen770jbj")

@onready var anim := $"../Transicao/AnimationPlayer"

func _init() -> void:
	pass


func _ready() -> void:
	var all_descendants = find_children("*", "Control", false, false)
	for node in all_descendants:
		count = count + 1
	@warning_ignore("integer_division")
	count = count / 2
	for i in count:
		print("i:" + str(i))
		cartas.append(i+1)
		cartas.append(i+1)
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0
	cartas.shuffle()
	var i := 0
	for node in all_descendants:
		node.valor_da_carta = cartas[i]
		i = i + 1


func _on_carta_teste() -> void:

	var all_descendants = find_children("*", "Control", false, false)
	
	
	if Global.selecionado_1 != Global.selecionado_2:
		await get_tree().create_timer(1.0).timeout
		Global.erros_nivel_2 += 1
		for node in all_descendants:
			if node.correto == false:
				if node.amostra:
					node.esconder_carta()
	else:
		acertos += 1
		for node in all_descendants:
			if node.amostra:
				node.correto = true
		if acertos == count:
			await get_tree().create_timer(1.0).timeout
			anim.play("fade_in")
			await anim.animation_finished
			get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 3/Nivel 3.tscn")
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0