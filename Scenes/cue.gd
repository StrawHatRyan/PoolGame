extends RigidBody3D

@export var move_speed: float = 3.0
@export var hover_height: float = 1.0

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10

func _physics_process(delta: float) -> void:
	var input_vector = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_vector.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_vector.z += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1

	input_vector = input_vector.normalized()

	# Apply movement
	var velocity = input_vector * move_speed
	velocity.y = linear_velocity.y  # Preserve vertical movement from gravity
	linear_velocity = velocity


	# Shoot cueball
	if Input.is_action_just_pressed("shoot"):
		apply_impulse(Vector3(0, 0, -15))

	for i in get_colliding_bodies():
		if i.name == "cueball":
			freeze = true
