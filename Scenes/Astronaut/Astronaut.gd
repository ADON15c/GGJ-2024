extends Node2D

const ARM_CONSTRAINT : Vector2 = Vector2(0, 225)
const LOWER_ARM_CONSTRAINT : Vector2 = Vector2(-135, 135)
const LEG_CONSTRAINT : Vector2 = Vector2(-20, 65)
const LOWER_LEG_CONSTRAINT : Vector2 = Vector2(-90, 90)
const BODY_CONSTRAINT : Vector2 = Vector2(-30, 30)

const ARM_POSES : Array[Vector2] = [
	Vector2(140, 105),
	Vector2(90, 270),
	Vector2(80, 0)
]
const LEG_POSES : Array[Vector2] = [
	Vector2(0, 0),
	Vector2(70, 60),
	Vector2(10, -90)
]

@onready var body : Sprite2D = $"Body"
@onready var left_arm : Sprite2D = $"Body/Left Arm"
@onready var left_lower_arm : Sprite2D = $"Body/Left Arm/Lower"
@onready var right_arm : Sprite2D = $"Body/Right Arm"
@onready var right_lower_arm : Sprite2D = $"Body/Right Arm/Lower"

@onready var left_leg : Sprite2D = $"Body/Left Leg"
@onready var left_lower_leg : Sprite2D = $"Body/Left Leg/Lower"
@onready var right_leg : Sprite2D = $"Body/Right Leg"
@onready var right_lower_leg : Sprite2D = $"Body/Right Leg/Lower"

var pose : Vector4i = Vector4i(0,0,0,0)
 
func _ready():
	set_pose(Vector4i(0, 0, 0, 0), 0)

func move_limb(limb : Sprite2D, new_rotation : float, dt : float):
	create_tween().tween_property(limb, "rotation_degrees", new_rotation, dt).set_trans(Tween.TRANS_CUBIC)

func set_pose(new_pose : Vector4i, dt : float):
	pose = new_pose
	
	move_limb(left_arm, ARM_POSES[new_pose.x].x, dt)
	move_limb(left_lower_arm, ARM_POSES[new_pose.x].y, dt)
	move_limb(right_arm, -ARM_POSES[new_pose.y].x, dt)
	move_limb(right_lower_arm, -ARM_POSES[new_pose.y].y, dt)
	move_limb(left_leg, LEG_POSES[new_pose.z].x, dt)
	move_limb(left_lower_leg, LEG_POSES[new_pose.z].y, dt)
	move_limb(right_leg, -LEG_POSES[new_pose.w].x, dt)
	move_limb(right_lower_leg, -LEG_POSES[new_pose.w].y, dt)
