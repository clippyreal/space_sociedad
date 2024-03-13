extends Area2D
var speed = 10

func _physics_process(_delta):
	var dir = Vector2.RIGHT.rotated(rotation)
	self.global_position += dir * speed

func _on_body_entered(_body):
	self.queue_free()
