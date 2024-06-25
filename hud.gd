extends CanvasLayer

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(txt):
	$Message.text = txt
	$Message.show()
	$MessageTimer.start()
	

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	# Code will not done until MessageTimer is done (2s)
	$Message.text = "Dodge\nthe cats!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
