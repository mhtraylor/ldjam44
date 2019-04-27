extends Node

# Arrow Keys / D-Pad -- Up, Down, Left, Right
# Space / X -- Accept / Select
# Esc / O -- Cancel

signal frame_input(inputs)

# Maximum number of inputs allowed
const MAX_BUTTONS = 4
const MAX_DIRECTIONS = 2

# Number of inputs being pressed
var num_buttons_pressed
var num_directions_pressed
var triggered_inputs


func _ready():
	num_buttons_pressed = 0
	num_directions_pressed = 0
	set_process(true)


func _process(delta):
	# Reset the max inputs and triggered inputs
	num_buttons_pressed = 0
	num_directions_pressed = 0
	triggered_inputs = []
	
	
	# Skip over illegal inputs
	if ((Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_down")) || (Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"))):
		return # Do not allow UP + DOWN or LEFT + RIGHT
	
	
	
	# Directional Priority: UP > DOWN > LEFT > RIGHT	
	if Input.is_action_pressed("ui_up") && !has_max_directions():
		triggered_inputs.append("ui_up")
		num_directions_pressed += 1
	
	if Input.is_action_pressed("ui_down") && !has_max_directions():
		triggered_inputs.append("ui_down")
		num_directions_pressed += 1
	
	if Input.is_action_pressed("ui_left") && !has_max_directions():
		triggered_inputs.append("ui_left")
		num_directions_pressed += 1
	
	if Input.is_action_pressed("ui_right") && !has_max_directions():
		triggered_inputs.append("ui_right")
		num_directions_pressed += 1
	
	
	# Check for buttons
	if Input.is_action_pressed("ui_cancel"):
		triggered_inputs.append("ui_cancel")
	
	if Input.is_action_pressed("ui_select"):
		triggered_inputs.append("ui_select")
	
	if Input.is_action_pressed("ui_accept"):
		triggered_inputs.append("ui_accept")
	
	
	output(triggered_inputs)


func has_max_directions() -> bool:
	return MAX_DIRECTIONS == num_directions_pressed


func has_max_buttons() -> bool:
	return MAX_BUTTONS == num_buttons_pressed


func output(inputs):
	if inputs.size() > 0:
		emit_signal("frame_input", inputs)