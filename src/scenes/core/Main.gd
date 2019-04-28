extends Node

onready var pauseNode = $Pause

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			unpause_game()
		else:
			pause_game()


func pause_game():
	pauseNode.pause()
	get_tree().paused = true


func unpause_game():
	pauseNode.unpause()
	get_tree().paused = false