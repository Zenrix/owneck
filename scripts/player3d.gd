extends KinematicBody

# class member variables go here, for example:
var motion = Vector3(0, 0, 0)
var speed = 5

var mousePosition
var relativeMousePosition

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
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
	pass