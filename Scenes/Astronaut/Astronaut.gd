extends Node2D

@onready var left_arm : Sprite2D = $"Body/Left Arm"
@onready var left_lower_arm : Sprite2D = $"Body/Left Arm/Lower"
@onready var right_arm : Sprite2D = $"Body/Right Arm"
@onready var right_lower_arm : Sprite2D = $"Body/Right Arm/Lower"

@onready var left_leg : Sprite2D = $"Body/Left Leg"
@onready var left_calf : Sprite2D = $"Body/Left Leg/Lower"
@onready var right_leg : Sprite2D = $"Body/Right Leg"
@onready var right_calf : Sprite2D = $"Body/Right Leg/Lower"

@onready var arms : Array[Sprite2D] = [left_arm, right_arm]
@onready var lower_arms : Array[Sprite2D] = [left_lower_arm, right_lower_arm]
@onready var legs : Array[Sprite2D] = [left_leg, right_leg]
@onready var calves : Array[Sprite2D] = [left_calf, right_calf]
@onready var limbs : Array[Sprite2D] = [left_arm, right_arm, left_leg, right_leg]
@onready var lower_limbs : Array[Sprite2D] = [left_lower_arm, right_lower_arm, left_calf, right_calf]

var step = 0.0;

func _process(delta):
	step += delta * 0.5;
	for limb : Sprite2D in limbs:
		limb.transform = limb.transform.rotated_local(sin(step));
	for lower_limb : Sprite2D in lower_limbs:
		lower_limb.transform = lower_limb.transform.rotated_local(cos(step));
		#lower_limb.transform = lower_limb.transform.rotated_local(delta)
	transform = transform.rotated_local(tan(step))
	pass
