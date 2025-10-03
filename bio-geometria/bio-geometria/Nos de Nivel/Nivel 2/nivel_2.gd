extends Control
var count := 0
var cartas: Array = []
signal custom_event()

#const Carta = preload("uid://bfxmnen770jbj")

func _init() -> void:
	pass


func _ready() -> void:
	var all_descendants = find_children("*", "", true, false) 
	for node in all_descendants:
		print("Processing descendant: " + node.name)
		count = count + 1
	@warning_ignore("integer_division")
	count = count / 2
	print(count)
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
		print(cartas[i])
		i = i + 1
	#
	#var all_descendants = find_children("*", "", true, false) 

	# "*" matches all names, "" matches all types, true for recursive, false to not own the array

	#for child in get_parent().get_children():
		#if child.has_method("teste"): # Or check if it's of a specific type
			#child.my_signal.connect(self.my_signal_handler)
			#print("Sucesso")


func _on_carta_teste() -> void:
	
	var all_descendants = find_children("*", "", true, false) 
	await get_tree().create_timer(1.0).timeout
	if Global.selecionado_1 != Global.selecionado_2:
		print("F")
		for node in all_descendants:
			if node.correto == false:
				node.esconder_carta()
	else:
		print("UAU")
		for node in all_descendants:
			if node.amostra == true:
				node.correto = true
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0
