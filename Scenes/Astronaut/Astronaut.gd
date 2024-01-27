extends Node2D

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

var step = 0.0;
var selected_limb_idx : int = 0

func _process(delta):
	step += delta * 0.5;
	for limb : Sprite2D in limbs:
		limb.transform = limb.transform.rotated_local(sin(step));
	for lower_limb : Sprite2D in lower_limbs:
		lower_limb.transform = lower_limb.transform.rotated_local(cos(step));
		#lower_limb.transform = lower_limb.transform.rotated_local(delta)
	transform = transform.rotated_local(tan(step))
	
	#step = delta * 0.5;
	#for limb : Sprite2D in limbs:
		#limb.transform = limb.transform.rotated_local(step);
	#for lower_limb : Sprite2D in lower_limbs:
		#lower_limb.transform = lower_limb.transform.rotated_local(step);
		##lower_limb.transform = lower_limb.transform.rotated_local(delta)
	#transform = transform.rotated_local(step)
	
	if Input.is_action_pressed("ui_left"):
		all_limbs[selected_limb_idx].transform = all_limbs[selected_limb_idx].transform.rotated_local(-delta*10 );
	if Input.is_action_pressed("ui_right"):
		all_limbs[selected_limb_idx].transform = all_limbs[selected_limb_idx].transform.rotated_local(delta*10);
	


func _input(event : InputEvent):
	if event is InputEventKey and event.is_pressed() and !event.is_echo():
		match event.keycode:
			KEY_SPACE:
				select_limb((selected_limb_idx + 1) % all_limbs.size())
			KEY_LEFT:
				all_limbs[selected_limb_idx]
			KEY_RIGHT:
				all_limbs[selected_limb_idx]

func select_limb(idx : int):
	all_limbs[selected_limb_idx].self_modulate = Color.WHITE
	selected_limb_idx = idx
	all_limbs[selected_limb_idx].self_modulate = Color.BLUE
