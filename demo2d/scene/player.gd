extends Area2D

signal hit

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO;
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	var animate_node = $AnimatedSprite2D as AnimatedSprite2D
	
	if velocity.length() > 0:
		var animate_name
		
		
		if velocity.x != 0:
			animate_name = "walk"
			animate_node.flip_v = false
			animate_node.flip_h = velocity.x < 0
		elif velocity.y != 0:
			animate_name = "up"
			animate_node.flip_h = false
		
		animate_node.play(animate_name)
		
		position += velocity.normalized() * speed * delta
		position = position.clamp(Vector2.ZERO, screen_size)
	else:
		animate_node.stop()
		
	pass


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	pass
