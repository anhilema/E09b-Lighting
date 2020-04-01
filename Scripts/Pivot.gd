extends Spatial

export var speed = 15
export var zoom_speed = 1.5
export var zoom_min = 5
export var zoom_max = 15

func _physics_process(delta):
	rotation_degrees.y += delta*speed
	$Camera.translation.z += delta*zoom_speed
	if $Camera.translation.z > zoom_max or $Camera.translation.z < zoom_min:
		zoom_speed *= -1
