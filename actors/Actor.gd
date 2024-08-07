extends CharacterBody2D
class_name Actor

@export var speed = 300.0

var state := State.IDLE
var moving_direction := Vector2.ZERO:
	set(value):
		moving_direction = value
var facing_direction := Vector2.DOWN

enum State {
	IDLE,
	MOVING
}


func _ready():
	moving_direction = Vector2.UP
	prints("moving_direction", moving_direction)


func _physics_process(delta):
	move_and_slide()
