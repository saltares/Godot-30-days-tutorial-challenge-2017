extends KinematicBody2D

var direction = Vector2()
var speed = 0

const TOP = Vector2(0, -1)
const RIGHT = Vector2(1, 0)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const MAX_SPEED = 400

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()
	
	if Input.is_action_pressed("move_up"):
		direction += TOP
	elif Input.is_action_pressed("move_down"):
		direction += DOWN
		
	if Input.is_action_pressed("move_right"):
		direction += RIGHT
	elif Input.is_action_pressed("move_left"):
		direction += LEFT
	
	if direction.length_squared() > 0:
		speed = MAX_SPEED
	else:
		speed = 0
		
	var velocity = speed * direction.normalized() * delta
	move(velocity)
	