extends Node

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var spawnPosition = $SpawnPath/SpawnPosition
	spawnPosition.progress_ratio = randf()
	var mob = mob_scene.instantiate()
	print("spawn position:", spawnPosition.position)
	
	mob.initialize(spawnPosition.position, $Player.position)
	add_child(mob)
	pass # Replace with function body.
