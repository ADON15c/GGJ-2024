extends Node

const letter_scene : PackedScene = preload("res://Scenes/Letter/Letter.tscn")

var keys = [];
var letters : Array[Letter] = []
var key_index = 0;
var good = true;
var size = 2;

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
	for letter in letters:
		letter.move(delta/2)
	
	var s = $Label;
	#s.text = "test %s: %s - %s" % [size, keys.reduce(func(i, accum): return "%s %s" % [i, accum], ""), good];
	s.text = "%s" % [keys.reduce(func(i, accum): return "%s %s" % [i, accum])]
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed() && !event.is_echo():
		if event.keycode == KEY_UP:
			size += 1;
		elif event.keycode == KEY_DOWN:
			size -= 1;
		elif letters.size() > 0 and event.keycode == letters[0].get_unicode():
			#key_index += 1;
			#if key_index >= keys.size(): 
				#next_move();
				#move_made.emit();
			#good = true;
			letters[0].hit()
		elif event.keycode == KEY_BRACKETLEFT:
			spawn_letter('B')
		else:
			good = false; # :(

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
	
func delete_letter():
	letters.remove_at(0)
