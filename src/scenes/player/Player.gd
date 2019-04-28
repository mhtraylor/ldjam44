extends KinematicBody2D

signal hit
signal death
signal spawn

const UP = Vector2(0, -1)
const SLOPE_STOP = 0

const GRAVITY = 800.0
const WALK_SPEED = 250
const JUMP_VELOCITY = -350
const JUMPS_ALLOWED = 1    # 2 jumps

var speed = Vector2(0,0)
var speed_now = Vector2(0,0)
var velocity = Vector2()
var jumps_used = 0

onready var raycasts = $FloorRaycasts

func _ready():
# func _ready(pos):
# 	position = pos
	emit_signal("spawn")


func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("ui_left"):
		speed.x = -WALK_SPEED
	elif Input.is_action_pressed("ui_right"):
		speed.x =  WALK_SPEED
	else:
		speed.x = 0
	
	speed_now.x = lerp(speed_now.x, speed.x, 0.2)
	velocity.x = speed_now.x
	
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	
	if _check_is_grounded():
		jumps_used = 0


func _input(event):
	if event.is_action_pressed("ui_accept") && jumps_used < JUMPS_ALLOWED:
		velocity.y = JUMP_VELOCITY
		jumps_used += 1


func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false


func _on_Player_body_entered(body):
	emit_signal("hit")
	$CollisionShape2D.call_deferred("set_disabled", true)


func _die():
	emit_signal("death")
	hide()