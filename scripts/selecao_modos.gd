extends Control

const MENU_PRINCIPAL = "res://cenas/menu_principal.tscn" 
const MODO_ENEM = "res://cenas/modo_enem.tscn"
@onready var color = $ColorRect

func _ready() -> void:
	color.visible = true
	color.modulate.a = 1.0
	var tween_in = create_tween()
	tween_in.tween_property(color, "modulate:a", 0.0, 0.5)
	await tween_in.finished
	color.visible = false

func _on_botao_normal_pressed() -> void:
	pass # Replace with function body.

func _on_botao_enem_pressed() -> void:
	fazer_fade_out(MODO_ENEM)

func _on_botao_voltar_pressed() -> void:
	fazer_fade_out(MENU_PRINCIPAL)


func fazer_fade_out(caminho_cena: String):
	color.visible = true
	var tween_out = create_tween()
	tween_out.tween_property(color, "modulate:a", 1.0, 0.5)
	await tween_out.finished
	get_tree().change_scene_to_file(caminho_cena)
