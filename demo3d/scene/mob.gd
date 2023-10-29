extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 20


func _physics_process(delta):
	move_and_slide()
	
func initialize(startPosition, targetPosition):
	look_at_from_position(startPosition, targetPosition)
	var speed = randf_range(min_speed, max_speed)
	rotate_y(randf_range(-PI/4, PI/4))	
	velocity = Vector3.FORWARD.rotated(Vector3.UP, rotation.y) * speed
	pass


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
	pass # Replace with function body.

func squash():
	squashed.emit()
	queue_free()
	
