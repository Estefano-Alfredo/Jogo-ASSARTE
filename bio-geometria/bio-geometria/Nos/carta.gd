extends Control

@onready var label := $Label
@onready var anim: AnimationPlayer = $AnimationPlayer

@export var valor_da_carta : int

var amostra := false
var correto := false

const ABELHA = preload("uid://cysxxnij258ql")
const ARARA = preload("uid://du2qxw3r8dyx1")
const LOBO = preload("uid://duoljuw5ie3sc")
const PANDA = preload("uid://bcjgxf86qujjv")
const TARTARUGA = preload("uid://d17lvrv7wxxrh")

@onready var texture: TextureRect = $TextureRect

signal teste

var conf := false
func _process(_delta: float) -> void:
	if conf	== true:
		return
	match valor_da_carta:
		1:
			texture.texture = ABELHA
		2:
			texture.texture = ARARA
		3:
			texture.texture = LOBO
		4:
			texture.texture = PANDA
		5:
			texture.texture = TARTARUGA

func esconder_carta():
	anim.play_backwards("flip")
	amostra = false


func _on_button_pressed() -> void:
	if amostra == false:
		if Global.selecionado_2 == 0:
			anim.play("flip")
			amostra = true
			label.text = str(valor_da_carta)
			if Global.selecionado_1 == 0:
				Global.selecionado_1 = valor_da_carta
			else:
				Global.selecionado_2 = valor_da_carta
				emit_signal("teste")


func _on_mouse_entered() -> void:
	if amostra == true:
		return

	


func _on_mouse_exited() -> void:
	if amostra == true:
		return
