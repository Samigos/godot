extends Node2D

@onready var timer = $Timer
@onready var path_follow_2d = $Player/Path2D/PathFollow2D
@onready var animation_player = $CanvasLayer2/ColorRect/AnimationPlayer
@onready var enemies = $Enemies

var count := 0 
var number_of_kills := 0

func _ready():
	_spawn_enemy()
	#timer.stop()

func _on_timer_timeout():
	_spawn_enemy()
	
func _spawn_enemy():
	var mob = preload("res://mob.tscn").instantiate()
	
	path_follow_2d.progress_ratio = randf()
	mob.global_position = path_follow_2d.global_position
	mob.enemy_died.connect(_on_mob_enemy_died)
	enemies.add_child(mob)
	
	count += 1
	print(count)

func _spawn_boss_enemy():
	var mob = preload("res://mob.tscn").instantiate()
	
	path_follow_2d.progress_ratio = randf()
	mob.scale = Vector2(2, 2)
	mob.health = 500
	mob.is_boss = true
	mob.global_position = path_follow_2d.global_position
	mob.enemy_died.connect(_on_mob_enemy_died)
	enemies.add_child(mob)
	
	count += 1
	print(count)
	
func _on_player_player_died():
	animation_player.play("visible")
	timer.stop()
	enemies.queue_free()
	await animation_player.animation_finished
	
	


func _on_mob_enemy_died(enemy):
	number_of_kills += 1 if enemy.is_boss else 1
	
	if number_of_kills % 5 == 0:
		timer.stop()
		_spawn_boss_enemy()
		
	if enemy.is_boss:
		timer.wait_time /= 1.5
		timer.start()
		
	print(number_of_kills)
	%ScoreLabel.text = "Slimes killed: " + str(number_of_kills)




func _on_button_button_down():
	get_tree().reload_current_scene()
