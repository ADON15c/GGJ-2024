extends Control


func _input(event):
	if event is InputEventKey and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/Intro/Intro.tscn")
