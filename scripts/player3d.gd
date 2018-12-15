extends KinematicBody

# class member variables go here, for example:
var motion = Vector3(0, 0, 0)
var speed = 5
var currentDistanceFromGround
var desiredDistanceFromGround = .5

var mousePosition
var relativeMousePosition
var cameraTracking = Vector3(0, 0, .5)

var mouse_scroll_value = 0
const MOUSE_SENSITIVITY_SCROLL_WHEEL = 0.08

func _ready():
	$groundFinder.set_enabled(true)
	$camera.translate(Vector3(0, 10, 4))
	$camera.look_at($collision.translation + Vector3(0, 1.5, 0), Vector3(0, 0, -1))

func _process(delta):
	### Maintain distance from the ground. Enables use of ramps.
	currentDistanceFromGround = self.translation.y - $groundFinder.get_collision_point().y

	if(currentDistanceFromGround > .8 && motion.y > -10):
		motion = motion - Vector3(0, 1, 0)
	if(currentDistanceFromGround < .8):
		motion = Vector3(motion.x, 0, motion.z)
	if(currentDistanceFromGround < .7):
		self.move_and_collide(.5 * motion + Vector3(0, .1, 0))
	
	### Movement
	if Input.is_action_pressed("ui_up"):
		motion.z = -1
	elif Input.is_action_pressed("ui_down"):
		motion.z = 1
	else:
		motion.z = 0

	if Input.is_action_pressed("ui_left"):
		motion.x = -1
	elif Input.is_action_pressed("ui_right"):
		motion.x = 1
	else:
		motion.x = 0
	
	motion = motion.normalized() * speed * delta
	self.move_and_collide(motion)
	
	### Camera/mouse tracking
	# Get mouse position
	mousePosition = get_viewport().get_mouse_position()

	# Positional information
	relativeMousePosition = mousePosition - OS.get_real_window_size() / 2

	# Camera control
	$camera.set_h_offset(relativeMousePosition.x / 80)
	$camera.set_v_offset(relativeMousePosition.y / -80)
	relativeMousePosition = relativeMousePosition.normalized()

func _input(event):
	### Camera zooming
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP or event.button_index == BUTTON_WHEEL_DOWN:
			if event.button_index == BUTTON_WHEEL_UP:
				mouse_scroll_value += MOUSE_SENSITIVITY_SCROLL_WHEEL
				$camera.translate_object_local(-cameraTracking)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				mouse_scroll_value -= MOUSE_SENSITIVITY_SCROLL_WHEEL
				$camera.translate_object_local(cameraTracking)