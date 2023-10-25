extends RigidBody2D

@onready var animated_node = $AnimatedSprite2D as AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var names = animated_node.sprite_frames.get_animation_names()
	animated_node.play(names[randi() % names.size()])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
