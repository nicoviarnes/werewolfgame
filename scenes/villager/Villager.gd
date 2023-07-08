extends KinematicBody2D

onready var sprite = $Sprite

enum states {PATROL, CHASE, DEAD}
var state = states.PATROL

var wander_speed = 20
var run_speed = 60
var direction = Vector2.ZERO # initialise direction

var min_move_distance = 100
var max_move_distance = 1000

var moved_distance = 0
var move_distance = 0

# Target for chase mode.
var player = null

var chase = true

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play("default")

func _physics_process(_delta):
	if player == null:
		move_and_slide(direction * wander_speed)

		moved_distance += direction.length() * wander_speed
		if moved_distance >= move_distance:
			direction = choose_random_direction()
			move_distance = rand_range(min_move_distance, max_move_distance)
			moved_distance = 0
	else:
		if chase:
			direction = (player.position - position).normalized()
			move_and_slide(direction * run_speed)
		else:
			direction = (-player.position + position).normalized()
			move_and_slide(direction * run_speed)			

func choose_random_direction():
	var choice = randi() % 4
	match choice:
		0:
			return Vector2.UP
		1:
			return Vector2.DOWN
		2:
			return Vector2.LEFT
		3:
			return Vector2.RIGHT


func _on_DetectionArea_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_DetectionArea_exited(body):
	if body.is_in_group("player"):
		player = null


func _on_day():
	chase = true


func _on_night():
	chase = false


