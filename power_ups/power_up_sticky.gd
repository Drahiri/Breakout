extends PowerUp

func _effect():
	EffectsManager.sticky_activated.emit()
	EffectsManager.active_sticky += 1
	$EffectDuration.start()


func _on_effect_duration_timeout():
	EffectsManager.active_sticky -= 1
	if EffectsManager.active_sticky == 0:
		EffectsManager.sticky_deactivated.emit()
	queue_free()
