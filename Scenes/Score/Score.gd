extends Node2D

@onready var game_state : GameState = get_node("/root/GameState")

@export_group("Extras")
@export var health_nodes: Array[Node2D] = [];
var score = 0;
var health = 3;
const health_bonus = 5;

func _process(delta):
	$Label.text = "Score: %s" % [score];
	for i in health_nodes.size():
		(health_nodes[i] as Health).update_body(health <= i);

func _on_fail():
	health -= 1;
	if health == 0:
		get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
func _on_success():
	game_state.score += 1;

