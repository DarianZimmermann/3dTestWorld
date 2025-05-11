extends CharacterBody3D

var speed
const WALK_SPEED = 4.0
const SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5

var mouse_sens = 0.001
var camera_anglex=0


func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	#Capture mouse movement for Infinite rotation
	if event is InputEventMouseMotion:
		#Rotate Character on Mouse movement left/right(absolute)
		rotate_y(-event.relative.x*mouse_sens)
		#Rotate camera on mouse movement up/down(relative)
		$Camera.rotate_object_local(Vector3(1,0,0),-event.relative.y*mouse_sens)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity #
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump #
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle Sprint #
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration #
	# As good practice, you should replace UI actions with custom gameplay actions #
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	move_and_slide()
