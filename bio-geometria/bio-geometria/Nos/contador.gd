extends Node

@onready var timer_label: Label = $MarginContainer/MarginContainer/Numeros # Replace $Label with the actual path to your Label node
@onready var count_up_timer: Timer = $Timer # Replace $Timer with the actual path to your Timer node

@export var ligado := true
@export var tempo : int

func _ready():
	# Connect the Timer's timeout signal to our update_timer_display function
	@warning_ignore("integer_division")
	var minutes = tempo / 60
	var seconds = tempo % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
	count_up_timer.timeout.connect(update_timer_display)
	# If Autostart is false, you would call count_up_timer.start() here or elsewhere.

func update_timer_display():
	if (not ligado) or (tempo <= 0):
		return
	Global.total_seconds += 1
	print(Global.total_seconds)
	tempo -= 1
	@warning_ignore("integer_division")
	var minutes = tempo / 60
	var seconds = tempo % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
