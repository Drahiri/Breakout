extends PowerUp

func _effect():
	EffectsManager.chaos_activated.emit()
	$EffectDuration.start()


func _on_effect_duration_timeout():
	EffectsManager.chaos_deactivated.emit()
	queue_free()
