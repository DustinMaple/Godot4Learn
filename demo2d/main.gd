extends Node

@export var mob_scene: PackedScene
var score

@onready var hud = $HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	# new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
#	for mob in $Mobs.get_children(false):
#		mob.queue_free()
	get_tree().call_group("mobs", "queue_free")
	hud.show_game_over()
	$Sound/Music.stop()
	$Sound/DeadSound.play()
	print("Game Over.Score=", score)
	pass # Replace with function body.

func new_game():
	hud.show_message("Get Ready")
	score = 0
	hud.update_score(score)
	$Player.start($StartPosition.position)
	$Sound/Music.play()
	$StartTimer.start()
	


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.


func _on_score_timer_timeout():
	score += 1
	hud.update_score(score)
	pass # Replace with function body.


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_location = $MobPath/MobSpawnLocation
	mob_location.progress_ratio = randf()
	
	var rotation = mob_location.rotation + PI / 2
	rotation += randf_range(-PI/4, PI/4)
	var position = mob_location.position
	
	var velocity = Vector2(randf_range(150, 250), 0)
	
	mob.linear_velocity = velocity.rotated(rotation)
	mob.rotation = rotation
	mob.position = position
	
	$Mobs.add_child(mob)
	



