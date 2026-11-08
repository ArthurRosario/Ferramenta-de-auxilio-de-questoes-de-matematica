extends Control

const CENA_MENU = "res://cenas/menu_principal.tscn" 

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(CENA_MENU)
