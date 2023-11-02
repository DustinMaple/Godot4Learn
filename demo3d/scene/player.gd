extends CharacterBody3D

signal dead

@export var speed = 14
@export var gravity = 75
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO
var bounce_impulse = 1

func _physics_process(delta):
	
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y -= gravity * delta
	elif Input.is_action_pressed("jump"):
		target_velocity.y = jump_impulse
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob") and Vector3.UP.dot(collision.get_normal()) > 0.1:
			print("squash:", index)
			var mob = collision.get_collider()
			mob.squash()
			target_velocity.y = bounce_impulse
			
	velocity = target_velocity
	move_and_slide()
	
	$Pivot.rotation.x = PI/6 * velocity.y / jump_impulse

func die():
	dead.emit()
	queue_free()

func _on_mob_detector_body_entered(body):
	die()
	pass # Replace with function body.
