extends CharacterBody2D

@export var initial_direction := Vector2(0.274721, -0.961524)
@export var initial_speed := 364

var direction := initial_direction
var speed := initial_speed

func _physics_process(delta):
	var collider := move_and_collide(direction * speed * delta)

	if (collider == null):
		return

	if (collider.get_collider().name == "Paddle"):
		direction = (position - collider.get_collider().position).normalized()
	else:
		if(collider.get_collider().is_in_group("blocks")):
			collider.get_collider().destroy()
		direction = direction.bounce(collider.get_normal())
