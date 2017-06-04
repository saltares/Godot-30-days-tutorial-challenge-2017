extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

var grid_size = Vector2(16, 16)
var grid = []

onready var Obstacle = preload("res://Obstacle.tscn")


func _ready():
	_initialize_grid()
	_initialize_player()
	_create_obstables()


func is_cell_vacant(pos, direction):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x >= grid_size.x or grid_pos.x < 0:
		return false
	if grid_pos.y >= grid_size.y or grid_pos.y < 0:
		return false

	return grid[grid_pos.x][grid_pos.y] == null


func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_pos())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null

	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type

	return map_to_world(new_grid_pos) + half_tile_size

func _initialize_grid():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

func _initialize_player():
	var player = get_node("Player")
	var start_pos = update_child_pos(player)
	player.set_pos(start_pos)

func _create_obstables():
	var positions = []

	for n in range(5):
		var grid_pos = Vector2(
			randi() % int(grid_size.x),
			randi() % int(grid_size.y)
		)
		if not grid_pos in positions:
			positions.append(grid_pos)

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.set_pos(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)
