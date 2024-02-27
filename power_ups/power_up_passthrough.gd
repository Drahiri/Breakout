extends PowerUp

func _effect():
	Ball.passthrough = true
	Ball.modulate = Color(1.0, 0.5, 0.5)
	Ball.active_passthrough_count += 1
	$EffectDuration.start()


func _on_effect_duration_timeout():
	Ball.active_passthrough_count -= 1
	if Ball.active_passthrough_count == 0:
		Ball.passthrough = false
		Ball.modulate = Color(1.0, 1.0, 1.0)
	queue_free()

