extends CharacterBody2D

@onready var happy_boo = %HappyBoo
@onready var hurt_box = $HurtBox
@onready var health_bar = $HealthBar

@export var health := 100
var is_dead := false

signal player_died

func  _physics_process(delta):
	if is_dead: return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 666
	
	if velocity:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
	
	var number_of_colliding_slimes = len(hurt_box.get_overlapping_bodies())
	health -= number_of_colliding_slimes * 0.05 * delta
	health_bar.value = health
	
	if health <= 0:
		is_dead = true
		player_died.emit()
		
	move_and_slide()
