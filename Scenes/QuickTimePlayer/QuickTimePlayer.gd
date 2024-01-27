extends Node

var keys = [];
var key_index = 0;
var good = true;
var size = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	next_move();
	pass # Replace with function body.

func next_move():
	keys = Array();
	keys.resize(size);
	keys.fill(0);
	keys = keys.map(func(i): return String.chr(randi_range(KEY_A,KEY_Z)));
	key_index = 0;
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var s = $Label;
	s.text = "test %s: %s - %s" % [size, keys.reduce(func(i, accum): return "%s %s" % [i, accum], ""), good];
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() && !event.is_echo():
		if event.keycode == KEY_UP:
			size += 1;
		elif event.keycode == KEY_DOWN:
			size -= 1;
		elif event.keycode == keys[key_index].unicode_at(0):
			key_index += 1;
			if key_index >= keys.size(): 
				next_move();
			good = true;
		else:
			good = false; # :(
