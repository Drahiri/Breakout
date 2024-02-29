extends PowerUp

@onready var chaos_effect = get_node("/root/Main/Effects/Chaos")

func _effect():
	$EffectDuration.start()
	chaos_effect.show()


func _on_effect_duration_timeout():
	chaos_effect.hide()
	queue_free()
