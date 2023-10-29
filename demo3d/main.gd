extends Node

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()
	$UserInterface/Retry.hide()
#	var mob = mob_scene.instantiate()
#	mob.initialize(Vector3(0.004169, 0.009606, -12.06451), $Player.position)
#	add_child(mob)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var spawnPosition = $SpawnPath/SpawnPosition
	spawnPosition.progress_ratio = randf()
	var mob = mob_scene.instantiate()
	
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	
	mob.initialize(spawnPosition.position, $Player.position)
	add_child(mob)
	pass # Replace with function body.


func _on_player_dead():
	$SpawnTimer.stop()
	$UserInterface/Retry.show()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
