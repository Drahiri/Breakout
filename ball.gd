extends CharacterBody2D

@export var initial_direction := Vector2(100.0, -350.0)
@export var initial_speed: float = 364.0

@onready var _direction: Vector2 = initial_direction.normalized()
@onready var speed: float = initial_speed

var sticky := false
var passthrough := false
var active_passthrough_count := 0

func _physics_process(delta: float):
	var collider = move_and_collide(_direction * speed * delta)

	if collider == null:
		return

	var normal_collision = collider.get_normal()
	collider = collider.get_collider()

	if collider.name == "Paddle":
		_direction = (position - collider.position).normalized()
	else:
		if collider.is_in_group("blocks") and not collider.is_solid:
			collider.destroy()
			if passthrough:
				return

		_direction = _direction.bounce(normal_collision)
