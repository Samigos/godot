extends Area2D

var travelled_distance := 0.0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * delta * 1111
	
	travelled_distance += delta * 1111
	
	if travelled_distance >= 10222:
		queue_free()



func _on_body_entered(body: Node2D):
	queue_free()

	if body.has_method("take_damage"):
		body.take_damage()
