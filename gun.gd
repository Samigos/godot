extends Area2D

func _physics_process(delta):
	var enemies = get_overlapping_bodies()
	
	if !enemies.is_empty():
		look_at(enemies[0].global_position)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()

func shoot():
	const BULLET = preload("res://bullet.tscn")
	
	var new_bullet = BULLET.instantiate()
	new_bullet.global_rotation = $Marker2D/Pistol/ShootingPoint.global_rotation
	new_bullet.global_position = $Marker2D/Pistol/ShootingPoint.global_position
	
	$Marker2D/Pistol/ShootingPoint.add_child(new_bullet)
