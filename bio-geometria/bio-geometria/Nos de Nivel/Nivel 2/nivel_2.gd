extends Control
var count := 1
var cartas: Array = []
var acertos : int = 0
#const Carta = preload("uid://bfxmnen770jbj")

@onready var anim := $"../Transicao/AnimationPlayer"
# --- INÍCIO DA MODIFICAÇÃO d relatoio ---
@onready var contador: Control = $"../Contador" # Referência ao nó do contador
# --- FIM DA MODIFICAÇÃO ---


func _init() -> void:
	pass


func _ready() -> void:
	# --- INÍCIO DA MODIFICAÇÃO de relatorio---
	# Precisamos pegar os filhos do GridContainer, não da cena inteira
	var all_descendants = $".".get_children()
	# --- FIM DA MODIFICAÇÃO ---
	
	# Limpa o count para contar apenas as cartas
	count = 0
	for node in all_descendants:
		# Garante que estamos contando apenas as cartas (que têm 'valor_da_carta')
		if node.has_meta("valor_da_carta") or node.has_method("esconder_carta"):
			count = count + 1
	
	@warning_ignore("integer_division")
	count = count / 2
	
	for i in count:
		print("i:" + str(i))
		cartas.append(i+1)
		cartas.append(i+1)
	
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0
	# Usar a variável de sessão correta
	Global.erros_nivel_2_atual = 0 
	
	cartas.shuffle()
	var i := 0
	for node in all_descendants:
		if node.has_meta("valor_da_carta") or node.has_method("esconder_carta"):
			node.valor_da_carta = cartas[i]
			i = i + 1


func _on_carta_teste() -> void:

	var all_descendants = $".".get_children()
	
	
	if Global.selecionado_1 != Global.selecionado_2:
		await get_tree().create_timer(1.0).timeout
		
		# --- INÍCIO DA MODIFICAÇÃO de relatorio ---
		# Salva na variável de sessão correta
		Global.erros_nivel_2_atual += 1
		print("Erros Nível 2: ", Global.erros_nivel_2_atual)
		# --- FIM DA MODIFICAÇÃO ---
		
		for node in all_descendants:
			if node.has_method("esconder_carta") and node.correto == false:
				if node.amostra:
					node.esconder_carta()
	else:
		acertos += 1
		for node in all_descendants:
			if node.has_method("esconder_carta") and node.amostra:
				node.correto = true
		if acertos == count:
			await get_tree().create_timer(1.0).timeout
			
			# --- INÍCIO DA MODIFICAÇÃO (Fase 3) ---
			# Para o contador e salva o tempo restante
			contador.ligado = false
			Global.tempo_restante_nivel_2_atual = contador.tempo
			print("Fase 2 completa. Erros: ", Global.erros_nivel_2_atual, " Tempo Restante: ", Global.tempo_restante_nivel_2_atual)
			
			# NÃO processa mais o relatório final aqui
			
			# Muda para a nova FASE 3
			anim.play("fade_in")
			await anim.animation_finished
			get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 3/Nivel 3.tscn") # IR PARA A FASE 3
			# --- FIM DA MODIFICAÇÃO ---
			
	Global.selecionado_1 = 0
	Global.selecionado_2 = 0
