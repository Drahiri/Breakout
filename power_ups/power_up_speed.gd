extends PowerUp

@export var ball_speed_multiplier := 1.2

func _effect():
	Ball.speed *= ball_speed_multiplier
	queue_free()
