@icon("res://scenes/console/command/command.png")
class_name Command
extends Node


@export var target: Node
@export var function: String
@export_multiline  var help: String
@export var parameters: Array[String]


### BUILT-IN ###


func _ready() -> void:
	assert(name == name.to_lower(), "Command name \"%s\" must be lower cased" % name)
	assert(target != null, "A command must be linked to a node")
	assert(!function.is_empty(), "A command must refer to a function")
	assert(target.has_method(function), "Function \"%s\" doesn't exist on the target" % function)
	_assert_paramters(parameters)


func _assert_paramters(parameters: Array[String]) -> void:
	for parameter in parameters:
		var param_split = parameter.split(":")
		var param_name = param_split[0]
		var param_type = param_split[1]

		if param_name.is_empty():
			assert(false, "A parameter has no name")

		if param_type not in ["string", "int", "float"]:
			assert(false, "Paramter \"%s\" has unknown type \"%s\", expected are [string, int, float]" % [param_name, param_type])
