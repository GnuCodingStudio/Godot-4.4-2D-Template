extends Node

const UI_CLICK = preload("res://components/uicontrols/UI_Click.wav")
const UI_HOVER = preload("res://components/uicontrols/UI_Hover.wav")


@onready var audio_player: AudioStreamPlayer = %AudioPlayer


func _ready() -> void:
	for child in get_parent().get_children():
		_bind_node(child)


func _bind_node(node: Node) -> void:
	if node is Button:
		_bind_button(node)
	elif node is CheckBox:
		_bind_checkbox(node)
	
	for child in node.get_children():
		_bind_node(child)


func _bind_button(button: Button) -> void:
	button.mouse_entered.connect(_play_sound.bind(UI_HOVER))
	button.pressed.connect(_play_sound.bind(UI_CLICK))


func _bind_checkbox(checkbox: CheckBox) -> void:
	checkbox.mouse_entered.connect(_play_sound.bind(UI_HOVER))
	checkbox.pressed.connect(_play_sound.bind(UI_CLICK))


func _play_sound(stream: AudioStream) -> void:
	audio_player.stop()
	audio_player.stream = stream
	audio_player.play()
