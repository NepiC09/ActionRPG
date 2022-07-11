extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight
var max_zoom = 1.5
var min_zoom = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = topLeft.position.x
	limit_top = topLeft.position.y
	limit_right = bottomRight.position.x
	limit_bottom = bottomRight.position.y

func _process(delta):
	if Input.is_action_just_released("scroll_up") and !zoom_max():
		zoom.x += 0.1
		zoom.y += 0.1
		
	if Input.is_action_just_released("scroll_down") and !zoom_min():
		zoom.x -= 0.1
		zoom.y -= 0.1

func zoom_max():
	if zoom.x >= max_zoom and zoom.y >= max_zoom:
		return 1
	else:
		return 0

func zoom_min():
	if zoom.x <= min_zoom and zoom.y <= min_zoom:
		return 1
	else:
		return 0
