extends Control


func _on_button_pressed() -> void:
	get_tree().quit()
	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Nos de Nivel/Nivel 1/level_1.tscn")


func _on_configurar_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/configuracao.tscn")
