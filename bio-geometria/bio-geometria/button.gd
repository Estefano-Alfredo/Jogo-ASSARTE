extends Button
@export var valor := -1

func _init() -> void:
	text = str(valor)
