extends Control




# função para voltar
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Menu/menu.tscn")
