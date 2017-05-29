extends Node2D

onready var screen_size = Vector2(Globals.get('display/width'), Globals.get('display/height'))

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = -get_node("Player").get_pos() + screen_size * 0.5
	get_viewport().set_canvas_transform(canvas_transform)

func update_camera():
	print("moved!")
	pass