extends Area2D

signal collected
signal death
signal spawn

var power_up_property_test


func _ready():
# func _ready(pos):
# 	position = pos
	power_up_property_test = rand_range(5, 9)
	emit_signal("spawn")




func _on_Item_body_entered(body):
	if body.name == "Player":
		_collected()


func _collected():
	emit_signal("collected")
	_death()


func _death():
	emit_signal("death")
	self.queue_free()