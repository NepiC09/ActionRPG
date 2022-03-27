extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = topLeft.position.x
	limit_top = topLeft.position.y
	limit_right = bottomRight.position.x
	limit_bottom = bottomRight.position.y
