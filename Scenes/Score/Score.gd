extends Node2D

var score = 0;
var health = 0;
const health_bonus = 5;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "Score: %s" % [score];
	

func _on_fail():
	health -= 1;
func _on_success():
	score += 1;

