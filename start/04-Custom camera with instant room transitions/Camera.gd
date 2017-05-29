extends Node2D

onready var window_size = OS.get_window_size()
onready var player = get_node("Player")
onready var player_grid_pos = get_player_grid_pos()


func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_grid_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)


func get_player_grid_pos():
	var pos = player.get_pos() - player.size * 0.5
	pos.x = floor(pos.x / window_size.x)
	pos.y = floor(pos.y / window_size.y)
	return pos


func update_camera():
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Matrix32()
	
	if new_player_grid_pos != player_grid_pos:
		player_grid_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_grid_pos * window_size
		get_viewport().set_canvas_transform(transform)
	
	return transform
