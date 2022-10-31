extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var navAgent: NavigationAgent

export var targetPath: NodePath
onready var target = get_node(targetPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	navAgent = $NavigationAgent
	navAgent.connect("velocity_computed", self, "_on_velocity_computed")
	
	# This just doesn't work here you have to call it later, why isn't it ready by now?
	#navAgent.set_target_location(target.global_transform.origin)
	
	# pass # Replace with function body.

func _physics_process(_delta):
	if navAgent.is_navigation_finished():
		move_and_slide(Vector3(0, -2, 0), Vector3.UP)
		return
		
	var targetPos = navAgent.get_next_location()
	# print(global_transform.origin, targetPos, target.global_transform.origin)
	var direction = global_transform.origin.direction_to(targetPos)
	$Arrow.look_at(targetPos, Vector3.UP)
	var velocity = direction * navAgent.max_speed
	velocity.y -= 2
	#print(velocity)
	move_and_slide(velocity, Vector3.UP)
	# transform.origin = targetPos

func _on_velocity_computed(safe_velocity: Vector3):
	print('velo compute', safe_velocity)
	# navAgent.set_target_location(target.global_transform.origin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	navAgent.set_target_location(target.global_transform.origin)
	#print(navAgent.get_target_location())
	# print(navAgent.is_target_reachable(), target.global_transform.origin)
	
	



func _on_CheckBox2_toggled(button_pressed):
	$Arrow.visible = button_pressed
