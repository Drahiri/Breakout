extends CharacterBody2D

@export var initial_direction := Vector2(100.0, -350.0)
@export var initial_speed: float = 364.0

@onready var speed: float = initial_speed
@onready var _after_stuck_velocity := initial_direction.normalized() * initial_speed

var stuck := true
var sticky := false
var active_sticky_count := 0
var passthrough := false
var active_passthrough_count := 0


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
		return

	if collider.is_in_group("blocks") and not collider.is_solid:
		collider.destroy()
		if passthrough:
			return

	velocity = velocity.bounce(collision_normal)
