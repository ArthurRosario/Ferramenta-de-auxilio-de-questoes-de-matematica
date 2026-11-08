extends Control

const CENA_MODOS = "res://cenas/menu_principal.tscn" 
const CENA_CREDITOS = "res://cenas/creditos.tscn"
@onready var animation_player = $AnimationPlayer
@onready var COLOR = $ColorRect

func _ready() -> void:
	COLOR.visible = false
	
func _on_button_pressed() -> void:
	COLOR.visible = true
	animation_player.play("transicao")
	await animation_player.animation_finishe
	get_tree().change_scene_to_file(CENA_MODOS)


func _on_button_2_pressed() -> void:
	COLOR.visible = true
	animation_player.play("transicao")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(CENA_CREDITOS)


func _on_button_3_pressed() -> void:
	get_tree().quit()
