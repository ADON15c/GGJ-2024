extends Node2D

@onready var game_state : GameState = get_node("/root/GameState")

@export_group("Extras")
@export var health_nodes: Array[Node2D] = [];
var score = 0;
var health = 0;
const health_bonus = 5;

func _process(delta):
	$Label.text = "Score: %s\ntest health: %s" % [game_state.score, health];
	for i in 3:
		(health_nodes[i] as Health).update_body(health - 1 < i);

func _on_fail():
	health -= 1;
func _on_success():
	game_state.score += 1;

