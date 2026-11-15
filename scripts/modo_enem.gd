extends Control

var perguntas: Array = []
var indice_atual: int = 0
var tempo_decorrido: float = 0.0
var jogo_pausado: bool = false

@onready var box_alternativas: VBoxContainer = $boxAlternativas
@onready var label_timer: Label = $timer
@onready var label_numero: Label = $fundo/numero_pergunta/Label
@onready var label_enunciado: Label = $fundo/pergunta/escrita/Label
@onready var menu_pause: Control = $menu_pause
@onready var botao_pause: TextureButton = $botao_pause

func _ready() -> void:
	carregar_json()
	carregar_pergunta()
	
	if botao_pause:
		botao_pause.pressed.connect(_on_botao_pause_pressed)

func _process(delta: float) -> void:
	if not jogo_pausado:
		tempo_decorrido += delta
		label_timer.text = "TIMER: %.1fs" % tempo_decorrido

func carregar_json() -> void:
	var arquivo = FileAccess.open("res://dados/modo_enem.json", FileAccess.READ)
	if arquivo:
		var texto = arquivo.get_as_text()
		var json = JSON.new()
		var erro = json.parse(texto)
		if erro == OK:
			perguntas = json.get_data()

func carregar_pergunta() -> void:
	if indice_atual >= perguntas.size():
		get_tree().change_scene_to_file("res://cenas/menu_pause.tscn")
		return
		
	var q = perguntas[indice_atual]
	label_numero.text = "PERGUNTA " + str(q["numero"])
	label_enunciado.text = q["enunciado"]
	
	tempo_decorrido = 0.0
	
	for filho in box_alternativas.get_children():
		if filho is CheckBox:
			filho.button_pressed = false
			
	var i = 0
	for filho in box_alternativas.get_children():
		if filho is CheckBox:
			if i < q["alternativas"].size():
				filho.text = q["alternativas"][i]
				filho.visible = true
			else:
				filho.visible = false
			i += 1

func _on_botao_confirmar_pressed() -> void:
	var alternativa_escolhida = -1
	var index = 0
	for filho in box_alternativas.get_children():
		if filho is CheckBox:
			if filho.button_pressed:
				alternativa_escolhida = index
				break
			index += 1
			
	if alternativa_escolhida == -1:
		return
		
	var q = perguntas[indice_atual]
	var acertou = (alternativa_escolhida == q["resposta_correta"])
	
	if acertou:
		print("Acertou!")
	else:
		print("Errou!")
		
	indice_atual += 1
	carregar_pergunta()

func _on_botao_pause_pressed() -> void:
	jogo_pausado = true
	menu_pause.visible = true

func retomar_jogo() -> void:
	jogo_pausado = false
