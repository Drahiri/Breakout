extends PowerUp

func _effect():
	Ball.sticky = true
	Ball.active_sticky_count += 1
	Paddle.modulate = Color(1.0, 0.5, 1.0)
	$EffectDuration.start()


func _on_effect_duration_timeout():
	Ball.active_sticky_count -= 1
	if Ball.active_sticky_count == 0:
		Ball.sticky = false
		Paddle.modulate = Color(1.0, 1.0, 1.0)
	queue_free()
