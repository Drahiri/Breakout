extends PowerUp

@export var ball_speed_multiplier := 1.2

func _effect():
	EffectsManager.speed_activated.emit(ball_speed_multiplier)
	queue_free()
