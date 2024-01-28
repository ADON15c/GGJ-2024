extends Node2D

@onready var player : AnimationPlayer = $AnimationPlayer

	
func change_scene():
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
