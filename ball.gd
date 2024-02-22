extends CharacterBody2D

@export var initial_direction := Vector2(100.0, -350.0)
@export var initial_speed: float = 364.0

var _direction: Vector2 = initial_direction.normalized()
var _speed: float = initial_speed

func _physics_process(delta: float):
	var collider := move_and_collide(_direction * _speed * delta)

	if collider == null:
		return

	if collider.get_collider().name == "Paddle":
		_direction = (position - collider.get_collider().position).normalized()
	else:
		if collider.get_collider().is_in_group("blocks"):
			collider.get_collider().destroy()

		_direction = _direction.bounce(collider.get_normal())
