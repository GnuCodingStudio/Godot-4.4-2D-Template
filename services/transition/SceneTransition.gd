extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer


#region logic

func change_scene(scene_path: String, block: Callable = func():pass) -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	block.call()
	get_tree().change_scene_to_file(scene_path)
	animation_player.play("fade_in")

#endregion logic
