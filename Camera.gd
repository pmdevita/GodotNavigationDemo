extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var follow_player = false

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_camera()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset_camera():
	transform.basis = Vector3(deg2rad(-16), 0, 0)
	set_fov(70)


func _physics_process(delta):
	if follow_player:
		look_at_agent()
	else:
		reset_camera()
	
	
func look_at_agent():
	look_at(get_node("%KinematicBody").transform.origin, Vector3.UP)
	var distance = transform.origin.distance_to(get_node("%KinematicBody").transform.origin)
	var fov = 800 / distance
	print(fov)
	set_fov(clamp(fov, 1, 179))


func _on_CheckBox_toggled(button_pressed):
	follow_player = button_pressed
