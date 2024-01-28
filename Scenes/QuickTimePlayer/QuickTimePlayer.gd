extends Node


const pose_scene : PackedScene = preload("res://Scenes/Pose/Pose.tscn")


var poses : Array[Pose] = []
var good = true;

var current_pose : Vector4i:
	set(value):
		current_pose = value
		changed_pose()

signal pose_changed(new_pose : Vector4i)
signal pose_success()
signal pose_failure()

func _ready():
	$Timer.timeout.connect(func(): spawn_pose())

func _process(delta):
	for pose in poses:
		pose.pos += delta/20


func _input(event):
	if event is InputEventKey and event.is_pressed() && !event.is_echo():
		match event.keycode:
			KEY_D:
				current_pose.x = (current_pose.x + 1) % 3
			KEY_F:
				current_pose.y = (current_pose.y + 1) % 3
			KEY_J:
				current_pose.z = (current_pose.z + 1) % 3
			KEY_K:
				current_pose.w = (current_pose.w + 1) % 3


func spawn_pose():
	var pose = pose_scene.instantiate()

	pose.pose = Vector4(randi_range(0,2), randi_range(0,2), randi_range(0,2) ,randi_range(0,2))
	pose.start = $"Letter Start Marker".position
	pose.end = $"Letter End Marker".position
	pose.fail_pos = 1.05
	pose.success.connect(success)
	pose.failed.connect(failure);
	
	add_child(pose)
	poses.append(pose)
	
	if poses.size() == 1:
		pose._on_made_available();

func success(pose):
	if poses.find(pose) != 0:
		return;
	poses.erase(pose)
	
	if poses.size() >= 1:
		poses[0]._on_made_available();
	pose_success.emit();

func failure():
	poses.remove_at(0)
	pose_failure.emit();

func changed_pose():
	pose_changed.emit(current_pose)
	for pose in poses:
		if current_pose == pose.pose:
			pose.hit()
