extends KinematicBody2D

signal hit
signal death
signal collect
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
var rotation_speed = 0
var jumps_used = 0

onready var raycasts = $FloorRaycasts

func _ready():
# func _ready(pos):
# 	position = pos
	$AnimatedSprite.modulate = Color('b2f4eb41')
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
	rotation_speed = speed_now.x / 16
	
	$AnimatedSprite.rotation += rotation_speed * delta
	velocity = move_and_slide(velocity)
	
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


func _die():
	emit_signal("death")
	hide()


func _collect_item(area):
	print(area.power_up_property_test)
	emit_signal("collect")


func _on_PlayerArea_area_entered(area):
	if area.name == "Item":
		_collect_item(area)
	else:
		emit_signal("hit")
