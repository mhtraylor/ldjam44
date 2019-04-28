extends StaticBody2D

var landing_sounds = ["Landing1", "Landing2", "Landing3"]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_player_landed():
	var landed_sound = landing_sounds[randi() % landing_sounds.size()]
	
	if landed_sound == "Landing1":
		$Landing1.play()
	elif landed_sound == "Landing2":
		$Landing2.play()
	elif landed_sound == "Landing3":
		$Landing3.play()
