class_name Actionner
extends Area2D

var _targeted_actionnable: Actionnable

@onready var audio_player: AudioStreamPlayer = %AudioPlayer


#region built-in


func _process(delta: float) -> void:
	_target_nearest_resource()
	if Input.is_action_just_pressed("action_activate"):
		_activate_targeted_resource()

#endregion built-in

#region logic

func _target_nearest_resource() -> void:
	var actionnables = get_overlapping_bodies().map(_get_actionnable_or_null).filter(_not_null)
	actionnables.sort_custom(_sort_by_distance)

	if actionnables.size() > 0:
		var new_target = actionnables[0]
		_set_targeted_actionnable(new_target)
	else:
		_reset_targeted_resource()


func _get_actionnable_or_null(body: Node2D) -> Actionnable:
	var actionnables = body.find_children("*", "Actionnable", false)
	if not actionnables.is_empty():
		if actionnables[0].is_actionnable():
			return actionnables[0]
	return null


func _sort_by_distance(a: Node2D, b: Node2D) -> bool:
	var distance_to_a = a.global_position.distance_to(self.global_position)
	var distance_to_b = b.global_position.distance_to(self.global_position)
	return (distance_to_a < distance_to_b)


func _not_null(node: Node2D) -> bool:
	return node != null

#endregion logic

#region private

func _set_targeted_actionnable(target: Actionnable) -> void:
	if target != _targeted_actionnable:
		if _targeted_actionnable != null:
			_targeted_actionnable.unselect()
		target.select()
		_targeted_actionnable = target


func _reset_targeted_resource() -> void:
	if _targeted_actionnable != null:
		_targeted_actionnable.unselect()
	_targeted_actionnable = null


func _activate_targeted_resource() -> void:
	if _targeted_actionnable != null:
		_targeted_actionnable.activate()
		audio_player.play()

#endregion private
