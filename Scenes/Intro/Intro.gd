extends Node2D

@onready var player : AnimationPlayer = $AnimationPlayer

func _ready():
	player.animation_finished.connect(change_scene)
	
func change_scene():
	print("please")
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
