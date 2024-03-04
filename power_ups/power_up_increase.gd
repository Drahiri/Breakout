extends PowerUp

@export var increase_by := 0.5

func _effect():
	EffectsManager.increase_activated.emit(increase_by)
	queue_free()
