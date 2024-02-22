extends CharacterBody2D

@export var speed: float = 500.0

func _physics_process(delta: float):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	move_and_collide(Vector2(direction * speed * delta, 0))
