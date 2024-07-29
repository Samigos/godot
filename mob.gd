extends CharacterBody2D

const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")

@onready var player = get_node("/root/Game/Player")
@onready var slime = $Slime
@export var health := 100
@export var speed := 300
@export var is_boss = false

signal enemy_died

func _ready():
	slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()

func take_damage():
	health -= 50
	slime.play_hurt()
	
	if health <= 0:
		enemy_died.emit(self)
		queue_free()
		_show_smoke()

func _show_smoke():
	var smoke = SMOKE_SCENE.instantiate()
	smoke.position = position
	get_parent().add_child(smoke)
