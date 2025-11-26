extends Node2D

var is_dragging: bool = false
var current_animal_node: Area2D = null
var line_drawer: Line2D = null

# --- INÍCIO DAS MODIFICAÇÕES (RELATÓRIO) ---
# Referências para os nós que instanciamos no Passo 1
@onready var contador_node: Control = $Contador
@onready var anim: AnimationPlayer = $Transicao/AnimationPlayer

var acertos: int = 0
var erros_f3: int = 0
# --- FIM DAS MODIFICAÇÕES ---


func _ready():
	for animal in get_tree().get_nodes_in_group("animais"):
		animal.input_event.connect(_on_animal_input_event.bind(animal))

func _on_animal_input_event(_viewport, event, _shape_idx, animal_node: Area2D):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		
		# Impede o clique se este animal já foi conectado
		if animal_node.get_meta("conectado", false):
			return
			
		is_dragging = true
		current_animal_node = animal_node
		
		line_drawer = Line2D.new()
		line_drawer.width = 10.0
		line_drawer.default_color = Color.WHITE
		line_drawer.z_index = 10
		
		line_drawer.points = [animal_node.position, animal_node.position]
		add_child(line_drawer)

func _process(_delta):
	# Atualiza a ponta da linha para seguir o mouse
	if is_dragging and line_drawer:
		line_drawer.points[1] = get_local_mouse_position()

func _input(event):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		if not is_dragging or not current_animal_node:
			return

		is_dragging = false
		var line_to_process = line_drawer
		line_drawer = null
		
		var global_mouse_pos = get_global_mouse_position()
		var target_habitat = _get_area_under_mouse(global_mouse_pos)
		
		if target_habitat and target_habitat.is_in_group("habitats"):
			
			var animal_id = current_animal_node.get_meta("habitat_id")
			var habitat_id = target_habitat.get_meta("habitat_id")
			
			if animal_id == habitat_id:
				# SUCESSO!
				line_to_process.points[1] = target_habitat.position 
				line_to_process.default_color = Color.GREEN
				current_animal_node.set_meta("conectado", true)
				
				# --- INÍCIO DA MODIFICAÇÃO (RELATÓRIO) ---
				acertos += 1
				_check_vitoria()
				# --- FIM DAS MODIFICAÇÕES ---
				
			else:
				# ERRO (Habitat errado)
				_flash_line_red_and_fade(line_to_process)
				
				# --- INÍCIO DA MODIFICAÇÃO (RELATÓRIO) ---
				erros_f3 += 1
				Global.erros_nivel_3_atual = erros_f3
				print("Erros Nível 3: ", Global.erros_nivel_3_atual)
				# --- FIM DAS MODIFICAÇÕES ---
		else:
			# ERRO (Soltou no vazio)
			_flash_line_red_and_fade(line_to_process)
			
			# --- INÍCIO DA MODIFICAÇÃO (RELATÓRIO) ---
			erros_f3 += 1
			Global.erros_nivel_3_atual = erros_f3
			print("Erros Nível 3: ", Global.erros_nivel_3_atual)
			# --- FIM DAS MODIFICAÇÕES ---
			
		current_animal_node = null

func _get_area_under_mouse(position: Vector2) -> Area2D:
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = position
	params.collide_with_areas = true
	
	params.collision_mask = 2 
	
	var results = space_state.intersect_point(params)
	
	if not results.is_empty():
		for result in results:
			if result.collider is Area2D:
				return result.collider
	
	return null

# Cria uma animação (Tween) para a linha piscar em vermelho e desaparecer.
func _flash_line_red_and_fade(line_to_flash: Line2D):
	var tween = get_tree().create_tween()
	
	line_to_flash.default_color = Color.RED
	
	tween.tween_interval(0.2)
	tween.tween_property(line_to_flash, "modulate:a", 0.0, 0.3)
	
	tween.tween_callback(line_to_flash.queue_free)


# --- INÍCIO DA NOVA FUNÇÃO (RELATÓRIO) ---
# Verifica se o jogo terminou e chama o relatório
func _check_vitoria():
	# Verifica se acertou os 3 animais
	if acertos >= 3:
		# Para o contador e salva o tempo
		contador_node.ligado = false
		Global.tempo_restante_nivel_3_atual = contador_node.tempo
		print("Fase 3 completa! Erros: ", Global.erros_nivel_3_atual, " Tempo Restante: ", Global.tempo_restante_nivel_3_atual)
		
		# Chama a função principal de cálculo e salvamento
		Global.processar_e_salvar_relatorio_final()
		
		# Inicia a transição e vai para a tela de relatório final
		anim.play("fade_in")
		await anim.animation_finished
		get_tree().change_scene_to_file("res://Nos de Menu/relatorio_final.tscn")
# --- FIM DA NOVA FUNÇÃO ---
