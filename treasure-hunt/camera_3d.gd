extends Camera3D

@export var target: Node3D  
var follow_speed = 5.0
var offset = Vector3(0, 2, -5)  

func _process(delta):
	if target:
		var target_position = target.global_transform.origin + offset
		global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)
