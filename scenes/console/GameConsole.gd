class_name GameConsole
extends PanelContainer


@onready var input: LineEdit = %Input
@onready var log: RichTextLabel = %Log

var _commands: Array[Command] = []


### BUILT-IN ###


func _ready() -> void:
	var commands = get_children().filter(func (child): return child is Command)
	var has_help = false
	for command in commands:
		_commands.push_back(command)
		if command.name == "help":
			has_help = true

	if not has_help:
		_commands.push_front(_create_help())

	log_info("Listed commands: %s" % _commands_as_string())


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("show_game_console"):
		if visible:
			if not input.has_focus():
				hide()
		else:
			show()
			input.call_deferred("grab_focus")

### SIGNALS ###


func _on_command_submitted(new_text: String) -> void:
	_execute_command(new_text)
	input.text = ""


func _on_submit_pressed() -> void:
	_execute_command(input.text)
	input.text = ""
	input.grab_focus()


### LOGIC ###


func log_info(info: String):
	log.append_text("[i]%s[/i]\n" % info)


func log_error(info: String):
	log.append_text("[color=#FF0000]%s[/color]\n" % info)


func _log_command(command: Command):
	log.append_text("Executing [b]%s[/b]...\n" % command.name)


func _commands_as_string() -> String:
	return ", ".join(_commands.map(func(c): return "[b]%s[/b]" % c.name))


func _create_help() -> Command:
	var help = Command.new()
	help.name = "help"
	help.target = self
	help.function = "_log_help"
	help.help = "Show help message."
	return help


func _execute_command(command_text: String):
	if command_text.is_empty():
		return

	var matches = _commands.filter(func(c): return c.name == command_text)
	if matches.is_empty():
		log_error("Command not found!")
		return

	var command: Command = matches[0]

	_log_command(command)
	command.target.call(command.function)


func _log_help():
	for command in _commands:
		log.append_text("[b]%s[/b] - " % command.name)
		log.append_text("%s\n" % command.help)
	log.append_text("--------------------\n")
