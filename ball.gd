extends CharacterBody2D

@export var initial_direction := Vector2(0.274721, -0.961524)
@export var initial_speed := 364

var direction := initial_direction
var speed := initial_speed

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
