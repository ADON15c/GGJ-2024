extends Node2D
class_name Health

func update_body(damaged: bool):
	(($Image as Sprite2D).texture as AtlasTexture).region.position.x = 0 if damaged else 16
