extends CanvasLayer

signal start_game

@onready var start_button = $StartButton
@onready var score_label = $ScoreLabel
@onready var message_label = $MessageLabel
@onready var message_timer = $MessageTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(msg):
	message_label.text = msg
	message_label.show()
	message_timer.start()

func show_game_over():
	show_message("Game Over")
	await message_timer.timeout
	
	message_label.text = "Dodge the creeps!"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()
	
func update_score(score):
	score_label.text = str(score)



func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()
	pass # Replace with function body.


func _on_message_timer_timeout():
	message_label.hide()
	pass # Replace with function body.
