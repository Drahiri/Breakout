extends CharacterBody2D

@export var speed: float = 500.0

func _ready():
	EffectsManager.increase_activated.connect(_on_increase_activated)

	EffectsManager.sticky_activated.connect(_on_sticky_activated)
	EffectsManager.sticky_deactivated.connect(_on_sticky_deactivated)


func _physics_process(delta: float):
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	move_and_collide(Vector2(direction * speed * delta, 0))


func reset():
	scale.x = 1.0
	position.x = get_viewport_rect().size.x / 2
	$Sprite2D.self_modulate = Color(1.0, 1.0, 1.0)
	set_physics_process(false)

#region Effects
func _on_increase_activated(increase_by: float):
	scale.x += increase_by


func _on_sticky_activated():
	$Sprite2D.self_modulate = Color(1.0, 0.5, 1.0)


func _on_sticky_deactivated():
	$Sprite2D.self_modulate = Color(1.0, 1.0, 1.0)
#endregion

