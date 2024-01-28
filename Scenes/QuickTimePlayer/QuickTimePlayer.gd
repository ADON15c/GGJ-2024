extends Node

const letter_scene : PackedScene = preload("res://Scenes/Letter/Letter.tscn")
const pose_scene : PackedScene = preload("res://Scenes/Pose/Pose.tscn")

var letters : Array[Letter] = []
var poses : Array[Pose] = []
var good = true;

var current_pose : Vector4i:
	set(value):
		current_pose = value
		$Label.text = str(current_pose.x) + "," + str(current_pose.y) + "," + str(current_pose.z) + "," + str(current_pose.w)
		changed_pose()


func _ready():
	$Timer.timeout.connect(func(): spawn_pose())

func _process(delta):
	for letter in letters:
		letter.pos += delta/2
	
	for pose in poses:
		pose.pos += delta/10

func _input(event):
	if event is InputEventKey and event.is_pressed() && !event.is_echo():
		if letters.size() > 0 and event.keycode == letters[0].get_unicode():
			#key_index += 1;
			#if key_index >= keys.size(): 
				#next_move();
				#move_made.emit();
			good = true;
			letters[0].hit()
		elif event.keycode == KEY_BRACKETLEFT:
			spawn_letter('B')
		elif event.keycode == KEY_BRACKETRIGHT:
			spawn_pose()
		else:
			good = false; # :(
		
		match event.keycode:
			KEY_D:
				current_pose.x = (current_pose.x + 1) % 3
			KEY_F:
				current_pose.y = (current_pose.y + 1) % 3
			KEY_J:
				current_pose.z = (current_pose.z + 1) % 3
			KEY_K:
				current_pose.w = (current_pose.w + 1) % 3

signal move_made;

func spawn_letter(key : String):
	var letter = letter_scene.instantiate()

	letter.letter = key
	letter.start = $"Letter Start Marker".position
	letter.end = $"Letter End Marker".position
	letter.fail_pos = 1.05
	letter.success.connect(delete_letter)
	letter.failed.connect(delete_letter)
	
	add_child(letter)
	letters.append(letter)
	
func spawn_pose():
	var pose = pose_scene.instantiate()

	pose.pose = Vector4(randi_range(0,2), randi_range(0,2), randi_range(0,2) ,randi_range(0,2))
	pose.start = $"Letter Start Marker".position
	pose.end = $"Letter End Marker".position
	pose.fail_pos = 1.05
	pose.success.connect(delete_pose)
	pose.failed.connect(delete_pose)
	
	add_child(pose)
	poses.append(pose)
	
func delete_letter():
	letters.remove_at(0)

func delete_pose():
	poses.remove_at(0)

func changed_pose():
	if poses.size() > 0 and current_pose == poses[0].pose:
		poses[0].hit()
