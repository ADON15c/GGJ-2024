extends Node2D
class_name Letter

@export var letter : String = 'A'
@export var start : Vector2
@export var end : Vector2
@export var fail_pos : float

@onready var texture : AtlasTexture = $Sprite2D.texture

var pos : float = 0

signal success
signal failed


func _ready():
	texture.region.position = Vector2((get_unicode() - 65) * 32, 0)
	update_position()

func get_unicode():
	return letter.to_ascii_buffer().decode_u8(0)

func move(new_pos : float):
	pos += new_pos
	update_position()

func set_pos(new_pos : float):
	pos = new_pos
	update_position()

func update_position():
	position = lerp(start, end, pos)
	if pos > fail_pos:
		failed.emit()
		queue_free()

func hit():
	success.emit()
	queue_free()
