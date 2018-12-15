extends MeshInstance

var position = Vector3(0, 0, 0)
var orientation = Vector3(0, 0, 0)
var upDirection = Vector3(0, 0, 0)

func _ready():
	self.translate(position)
#	upDirection.x = orientation.z
#	upDirection.y = orientation.x
#	upDirection.z = orientation.y
	self.look_at(Vector3(0, -1, 0), Vector3(1, 0, 0))

func init(position, orientation):
	self.position = position
	self.orientation = orientation