class_name Actionnable
extends Node2D


signal on_select()
signal on_unselect()
signal on_activated()

var _actionnable: bool = false


func select() -> void:
	on_select.emit()


func unselect() -> void:
	on_unselect.emit()


func activate() -> void:
	on_activated.emit()


func set_actionnable(actionnable: bool) -> void:
	_actionnable = actionnable


func is_actionnable() -> bool:
	return _actionnable
