extends CharacterBody2D

@export var initial_direction := Vector2(100.0, -350.0)
@export var initial_speed: float = 364.0

@onready var speed: float = initial_speed
@onready var _after_stuck_velocity := initial_direction.normalized() * initial_speed

var stuck := true
var sticky := false
var passthrough := false

signal shake
signal exited

func _ready():
	EffectsManager.passthrough_activated.connect(_on_pasthrough_activated)
	EffectsManager.passthrough_deactivated.connect(_on_pasthrough_deactivated)

	EffectsManager.speed_activated.connect(_on_speed_activated)

	EffectsManager.sticky_activated.connect(_on_sticky_activated)
	EffectsManager.sticky_deactivated.connect(_on_sticky_deactivated)


func _physics_process(delta: float):
	if stuck:
		velocity = Vector2()
		move_and_slide()
		if Input.is_action_just_pressed("release_ball"):
			stuck = false
			velocity = _after_stuck_velocity
		return

	var collider = move_and_collide(velocity * delta)
	if collider != null:
		_resolve_collisions(collider.get_collider(), collider.get_normal())


func _resolve_collisions(collider: Node2D, collision_normal: Vector2):
	if collider.name == "Paddle":
		velocity = (position - collider.position).normalized() * speed
		_after_stuck_velocity = velocity
		stuck = sticky
		$SolidSound.play()
		return

	if collider.is_in_group("blocks") and not collider.is_solid:
		collider.destroy()
		$NormalSound.play()
		if passthrough:
			return
	else:
		shake.emit()
		$SolidSound.play()

	velocity = velocity.bounce(collision_normal)


func reset(reset_position: Vector2):
	sticky = false
	stuck = true
	speed = initial_speed
	position = Vector2(reset_position.x, reset_position.y - 25.0)
	$Sprite2D.self_modulate = Color(1.0, 1.0, 1.0)

#region Effects
func _on_pasthrough_activated():
	passthrough = true
	$Sprite2D.self_modulate = Color(1.0, 0.5, 0.5)


func _on_pasthrough_deactivated():
	passthrough = false
	$Sprite2D.self_modulate = Color(1.0, 1.0, 1.0)


func _on_speed_activated(multiplier: float):
	speed *= multiplier
	velocity = velocity.normalized() * speed


func _on_sticky_activated():
	sticky = true


func _on_sticky_deactivated():
	sticky = false
	stuck = false
#endregion


func _on_visible_on_screen_notifier_2d_screen_exited():
	_after_stuck_velocity = initial_direction.normalized() * initial_speed
	exited.emit()
