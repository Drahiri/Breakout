extends PowerUp

@export var increase_size := 0.5

func _effect():
	Paddle.scale.x += increase_size
	queue_free()
