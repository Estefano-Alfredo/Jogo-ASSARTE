extends VideoStreamPlayer


func _on_button_button_up() -> void:
	stop()
	finished.emit()
