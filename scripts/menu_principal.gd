extends Control

const CENA_MODOS = "res://cenas/selecao_modos.tscn" 
const CENA_CREDITOS = "res://cenas/creditos.tscn"
@onready var animation_player = $AnimationPlayer
@onready var color = $ColorRect

func _ready() -> void:
	color.visible = true
	color.modulate.a = 1.0
	var tween_in = create_tween()
	tween_in.tween_property(color, "modulate:a", 0.0, 0.5)
	await tween_in.finished
	color.visible = false
	
func _on_button_pressed() -> void:
	fazer_fade_out(CENA_MODOS)


func _on_button_2_pressed() -> void:
	fazer_fade_out(CENA_CREDITOS)


func _on_button_3_pressed() -> void:
	get_tree().quit()
	
func fazer_fade_out(caminho_cena: String):
	color.visible = true
	var tween_out = create_tween()
	tween_out.tween_property(color, "modulate:a", 1.0, 0.5)
	await tween_out.finished
	get_tree().change_scene_to_file(caminho_cena)
	
	
	
	
	
	
