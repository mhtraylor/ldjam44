extends Node

var sound
var music
var t

func _ready():
	t = Timer.new()
	t.connect("timeout", self, "_on_timer_timeout")
	add_child(t)
	sound = get_node("SelectSound")
	music = get_node("MenuMusic")
	music.play()
	t.set_wait_time(1.5)


#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		music.stop()
		play_sound()
		

func play_sound():
	sound.play()
	t.start()
	
func _on_timer_timeout():
	sound.stop()
	get_tree().change_scene("res://scenes/core/Main.tscn")