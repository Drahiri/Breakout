extends Node2D

func _ready():
	$Chaos.hide()
	$Confuse.hide()
	$Shake.hide()

	EffectsManager.chaos_activated.connect(_on_chaos_activated)
	EffectsManager.chaos_deactivated.connect(_on_chaos_deactivated)
	EffectsManager.confuse_activated.connect(_on_confuse_activated)
	EffectsManager.confuse_deactivated.connect(_on_confuse_deactivated)

func _process(_delta):
	pass

func _on_chaos_activated():
	$Chaos.show()

func _on_chaos_deactivated():
	$Chaos.hide()

func _on_confuse_activated():
	if not $Chaos.is_visible():
		$Confuse.show()

func _on_confuse_deactivated():
	$Confuse.hide()


func _on_shake():
	$Shake.show()
	$Shake/ShakeTime.start()


func _on_shake_time_timeout():
	$Shake.hide()
