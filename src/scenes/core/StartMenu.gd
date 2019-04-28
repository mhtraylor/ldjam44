extends Node

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/core/Main.tscn")