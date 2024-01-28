extends Node2D

func _ready():
	$QuickTimePlayer.pose_changed.connect(func(new_pose: Vector4i): $Astronaut.set_pose(new_pose, 1))
