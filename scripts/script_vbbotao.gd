extends TextureButton

var posicao_original_y: float
var escala_original: Vector2
var esta_em_container: bool = false
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer if has_node("AudioStreamPlayer") else null

func _ready() -> void:
	escala_original = scale
	posicao_original_y = position.y
	pivot_offset = size / 2
	
	if get_parent() is Container:
		esta_em_container = true
		
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_mouse_entered() -> void:
	var tween = create_tween()
	if esta_em_container:
		tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1)
	else:
		tween.tween_property(self, "position:y", posicao_original_y - 6, 0.1)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	if esta_em_container:
		tween.tween_property(self, "scale", escala_original, 0.1)
	else:
		tween.tween_property(self, "position:y", posicao_original_y, 0.1)

func _on_button_down() -> void:
	var tween = create_tween()
	if esta_em_container:
		tween.tween_property(self, "scale", Vector2(0.95, 0.95), 0.05)
	else:
		tween.tween_property(self, "position:y", posicao_original_y + 2, 0.05)
	
	# Toca o som automaticamente se o botão tiver o AudioStreamPlayer configurado
	if audio_player and audio_player.stream:
		audio_player.play()

func _on_button_up() -> void:
	var tween = create_tween()
	if esta_em_container:
		tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.05)
	else:
		tween.tween_property(self, "position:y", posicao_original_y - 6, 0.05)
