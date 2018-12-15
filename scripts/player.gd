extends KinematicBody2D

# class member variables go here, for example:
var motion = Vector2(0, 0)
var speed = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		motion.y = -1
	elif Input.is_action_pressed("ui_down"):
		motion.y = 1
	else:
		motion.y = 0
		
	if Input.is_action_pressed("ui_left"):
		motion.x = -1
	elif Input.is_action_pressed("ui_right"):
		motion.x = 1
	else:
		motion.x = 0
	
	motion = motion.normalized() * speed * delta
	self.move_and_collide(motion)
	pass
