extends Node2D

const ARM_CONSTRAINT : Vector2 = Vector2(0, 225)
const LOWER_ARM_CONSTRAINT : Vector2 = Vector2(-135, 135)
const LEG_CONSTRAINT : Vector2 = Vector2(-20, 65)
const LOWER_LEG_CONSTRAINT : Vector2 = Vector2(-90, 90)
const BODY_CONSTRAINT : Vector2 = Vector2(-30, 30)

@onready var body : Sprite2D = $"Body"
@onready var left_arm : Sprite2D = $"Body/Left Arm"
@onready var left_lower_arm : Sprite2D = $"Body/Left Arm/Lower"
@onready var right_arm : Sprite2D = $"Body/Right Arm"
@onready var right_lower_arm : Sprite2D = $"Body/Right Arm/Lower"

@onready var left_leg : Sprite2D = $"Body/Left Leg"
@onready var left_lower_leg : Sprite2D = $"Body/Left Leg/Lower"
@onready var right_leg : Sprite2D = $"Body/Right Leg"
@onready var right_lower_leg : Sprite2D = $"Body/Right Leg/Lower"

@onready var arms : Array[Sprite2D] = [left_arm, right_arm]
@onready var lower_arms : Array[Sprite2D] = [left_lower_arm, right_lower_arm]
@onready var legs : Array[Sprite2D] = [left_leg, right_leg]
@onready var lower_legs : Array[Sprite2D] = [left_lower_leg, right_lower_leg]
@onready var limbs : Array[Sprite2D] = arms + legs
@onready var lower_limbs : Array[Sprite2D] = lower_arms + lower_legs
@onready var all_limbs : Array[Sprite2D] = limbs + lower_limbs

@export var limb_resources : Array[Limb]

var selected_limb_idx : int = 0



func _process(delta):
	pass
	#if Input.is_action_pressed("ui_left"):
		#all_limbs[selected_limb_idx].transform = all_limbs[selected_limb_idx].transform.rotated_local(-delta*10 );
	#if Input.is_action_pressed("ui_right"):
		#all_limbs[selected_limb_idx].transform = all_limbs[selected_limb_idx].transform.rotated_local(delta*10);
	


func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		match event.keycode:
			KEY_SPACE:
				new_pose(0.25)
				#select_limb((selected_limb_idx + 1) % all_limbs.size())
			#KEY_LEFT:
				#all_limbs[selected_limb_idx]
			#KEY_RIGHT:
				#all_limbs[selected_limb_idx]


func new_pose(dt : float):
	move_limb(body, randf_range(BODY_CONSTRAINT.x, BODY_CONSTRAINT.y), dt)
	
	move_limb(left_arm, randf_range(ARM_CONSTRAINT.x, ARM_CONSTRAINT.y), dt)
	move_limb(right_arm, randf_range(-ARM_CONSTRAINT.x, -ARM_CONSTRAINT.y), dt)
	move_limb(left_lower_arm, randf_range(LOWER_ARM_CONSTRAINT.x, LOWER_ARM_CONSTRAINT.y), dt)
	move_limb(right_lower_arm, randf_range(-LOWER_ARM_CONSTRAINT.x, -LOWER_ARM_CONSTRAINT.y), dt)
	move_limb(left_leg, randf_range(LEG_CONSTRAINT.x, LEG_CONSTRAINT.y), dt)
	move_limb(right_leg, randf_range(-LEG_CONSTRAINT.x, -LEG_CONSTRAINT.y), dt)
	move_limb(left_lower_leg, randf_range(LOWER_LEG_CONSTRAINT.x, LOWER_LEG_CONSTRAINT.y), dt)
	move_limb(right_lower_leg, randf_range(-LOWER_LEG_CONSTRAINT.x, -LOWER_LEG_CONSTRAINT.y), dt)


func move_limb(limb : Sprite2D, new_rotation : float, dt : float):
	create_tween().tween_property(limb, "rotation_degrees", new_rotation, dt).set_trans(Tween.TRANS_CUBIC)


#func select_limb(idx : int):
	#all_limbs[selected_limb_idx].self_modulate = Color.WHITE
	#selected_limb_idx = idx
	#all_limbs[selected_limb_idx].self_modulate = Color.BLUE
