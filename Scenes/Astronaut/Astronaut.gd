extends Node2D

@onready var left_arm : Sprite2D = $"Body/Left Arm"
@onready var left_lower_arm : Sprite2D = $"Body/Left Arm/Left Lower Arm"
@onready var right_arm : Sprite2D = $"Body/Right Arm"
#@onready var right_lower_arm : Polygon2D = $"Body/Right Arm/Right Lower Arm"

#@onready var left_leg : Polygon2D = $"Body/Left Leg"
#@onready var left_calf : Polygon2D = $"Body/Left Leg/Left Calf"
#@onready var right_leg : Polygon2D = $"Body/Right Leg"
#@onready var right_calf : Polygon2D = $"Body/Right Leg/Right Calf"

#@onready var arms : Array[Polygon2D] = [left_arm, right_arm]
#@onready var lower_arms : Array[Polygon2D] = [left_lower_arm, right_lower_arm]
#@onready var legs : Array[Polygon2D] = [left_leg, right_leg]
#@onready var calves : Array[Polygon2D] = [left_calf, right_calf]
@onready var limbs : Array[Sprite2D] = [left_arm]
@onready var lower_limbs : Array[Sprite2D] = [left_lower_arm]


func _process(delta):
	for limb : Sprite2D in limbs:
		limb.transform = limb.transform.rotated_local(delta)
	for lower_limb : Sprite2D in lower_limbs:
		lower_limb.transform = lower_limb.transform.rotated_local(delta)
	pass
