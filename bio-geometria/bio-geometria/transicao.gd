extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$".".visible = true
	$".".mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_ENABLED
	animation_player.play("fade_out")
	await animation_player.animation_finished
	$".".mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
	set_default_cursor_shape(CURSOR_ARROW)


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$".".mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_DISABLED
		await animation_player.animation_finished
		$".".mouse_behavior_recursive = Control.MOUSE_BEHAVIOR_ENABLED
