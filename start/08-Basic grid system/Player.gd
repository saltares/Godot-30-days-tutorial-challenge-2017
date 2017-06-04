extends KinematicBody2D

var direction = Vector2()

const TOP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
var type
var grid

var speed = 0
const MAX_SPEED = 400

var velocity = Vector2()
var is_moving = false
var target_pos = Vector2()
var target_dir = Vector2()

func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction = TOP
	elif Input.is_action_pressed("move_down"):
		direction = DOWN
	elif Input.is_action_pressed("move_left"):
		direction = LEFT
	elif Input.is_action_pressed("move_right"):
		direction = RIGHT

	if direction.length_squared() > 0:
		pass

	if not is_moving and direction.length_squared() > 0:
		target_dir = direction
		if grid.is_cell_vacant(get_pos(), target_dir):
			target_pos = grid.update_child_pos(self)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_dir * delta

		var pos = get_pos()
		var distance_to_target = Vector2(
			abs(target_pos.x - pos.x),
			abs(target_pos.y - pos.y)
		)

		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_dir.x
			is_moving = false

		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_dir.y
			is_moving = false

		move(velocity)

