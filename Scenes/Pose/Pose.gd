extends Node2D
class_name Pose

@export var pose : Vector4i
@export var start : Vector2
@export var end : Vector2
@export var fail_pos : float


var pos : float:
	set(value):
		pos = value
		position = lerp(start, end, pos)
		if pos > fail_pos:
			failed.emit()
			queue_free()

signal success
signal failed


func _ready():
	$Astronaut.set_pose(pose, 0.1)
	pos = pos

func hit():
	success.emit()
	queue_free()
