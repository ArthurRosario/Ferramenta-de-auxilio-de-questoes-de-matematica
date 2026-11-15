extends Control


func _ready() -> void:
	visible = true

func _on_btn_continuar_pressed() -> void:
	visible = false
	if get_parent().has_method("retomar_jogo"):
		get_parent().retomar_jogo()

func _on_btn_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu_principal.tscn")
