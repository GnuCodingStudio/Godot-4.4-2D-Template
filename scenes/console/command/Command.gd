@icon("res://scenes/console/command/command.png")
class_name Command
extends Node


@export var target: Node
@export var function: String
@export_multiline  var help: String
@export var parameters: Array[String]

enum ParameterType {
	STRING,
	INT,
	FLOAT
}

### BUILT-IN ###


func _ready() -> void:
	assert(name == name.to_lower(), "Command name \"%s\" must be lower cased" % name)
	assert(target != null, "A command must be linked to a node")
	assert(!function.is_empty(), "A command must refer to a function")
	assert(target.has_method(function), "Function \"%s\" doesn't exist on the target" % function)
